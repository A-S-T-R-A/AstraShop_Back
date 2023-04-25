import { Database } from "../../database/index.mjs";
import { object, string } from "yup";
import { Op } from "sequelize";

const names = {
  low_price: "low_price",
  high_price: "high_price",
  price: "price",
};

const order_dict = {
  [names.low_price]: "ASC",
  [names.high_price]: "DESC",
};

const querySchema = object()
  .shape({
    orderBy: string().oneOf([names.low_price, names.high_price]),
    [names.price]: string().matches(/^\d+\-?\d+?$/, {
      excludeEmptyString: true,
    }),
    attr: string().matches(/^\d+(,\d+)*$/),
  })
  .noUnknown(true);

export async function getCategoryProducts(req, res) {
  const db = Database().getInstance();

  const {
    params: { id },
    query,
  } = req;

  let validationResult;

  try {
    validationResult = await querySchema.validate(query);
  } catch (err) {
    console.error(err);
    res.sendStatus(400);
    return;
  }

  const { category, product } = db.models;

  let result;

  const productParams = {
    model: product,
    attributes: ["id", "name", "price", "images", "description"],
  };

  const categoryParams = {
    attributes: ["parent_category_id", "id", "name", "image", "icon", "hru"],
    include: productParams,
  };

  if (validationResult.orderBy) {
    categoryParams.order = [
      [product, names.price, order_dict[validationResult.orderBy]],
    ];
  }

  if (validationResult.price) {
    const [min, max] = validationResult.price.split("-");

    productParams.where = {
      price: {
        [Op.between]: [min, max],
      },
    };
  }

  if (validationResult.attr) {
    const { product_attributes } = db.models;

    productParams.include = {
      model: product_attributes,
      attributes: [],
      where: {
        product_attribute_value_id: {
          [Op.or]: validationResult.attr.split(",").map((el) => parseInt(el)),
        },
      },
    };
  }

  try {
    result = await category.findByPk(id, categoryParams);

    if (!result) {
      return res.sendStatus(204);
    }
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
    return;
  }

  res.json(result);
}
