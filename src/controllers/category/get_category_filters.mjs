import { array, number, object, string } from "yup";
import { Database } from "../../database/index.mjs";

const inputSchema = object().shape({
  categoryId: number().required(),
});

const TYPES = {
  PRICE_RANGE: "price_range",
  ATTRIBUTES: "attributes",
};

const outputSchema = array().of(
  object().shape({
    type: string().oneOf([TYPES.PRICE_RANGE, TYPES.ATTRIBUTES]).required(),
    name: string().required(),
    info: object().when("type", {
      is: TYPES.PRICE_RANGE,
      then: () =>
        object().shape({
          from: number().required(),
          to: number().required(),
        }),
      otherwise: () =>
        array().of(
          object().shape({
            id: number().required(),
            name: string().required(),
          })
        ),
    }),
  })
);

export async function getCategoryFilters(req, res) {
  let validData;

  try {
    validData = await inputSchema.validate(req.params);
  } catch (err) {
    console.log(err);
    return res.sendStatus(400);
  }

  const db = Database().getInstance();

  const { attribute_types, attribute_values, product, category_attributes } =
    db.models;

  const priceRangeFilter = {
    type: TYPES.PRICE_RANGE,
    info: {
      from: 0,
      to: 0,
    },
    name: "Price",
  };

  const filters = [priceRangeFilter];

  let result;

  try {
    result = Promise.all([
      product.max("price", {
        where: { parent_category_id: validData.categoryId },
      }),
      category_attributes.findAll({
        where: { category_id: validData.categoryId },
        attributes: [],
        include: {
          model: attribute_types,
          attributes: ["name"],
          include: {
            attributes: ["id", "name"],
            model: attribute_values,
          },
        },
      }),
    ]);

    const [maxPrice, attributes] = await result;

    if (!maxPrice)
      return res.status(404).json({
        message: "No products in this category",
      });

    priceRangeFilter.info.to = maxPrice;

    filters.push(
      ...attributes.map((el) => {
        el = el.toJSON();

        return {
          type: TYPES.ATTRIBUTES,
          name: el.attribute_type.name,
          info: el.attribute_type.attribute_values.map((el) => ({
            id: el.id,
            name: el.name,
          })),
        };
      })
    );
  } catch (err) {
    console.log(err);
    return res.sendStatus(500);
  }

  try {
    await outputSchema.validate(filters);
  } catch (err) {
    console.log(err);
    return res.sendStatus(500);
  }

  res.json(filters);
}
