import { Database } from "../../database/index.mjs";

export async function getCategoryFilters(req, res) {
  const db = Database().getInstance();

  const {
    params: { id },
  } = req;

  const { category, category_filters, attribute_types, attribute_values } =
    db.models;

  let result;

  try {
    result = await category.findByPk(id, {
      include: {
        model: category_filters,
        attributes: ["id", "name", "info", "type", "value"],
      },
    });

    result = result.toJSON();

    for (let i = 0; i < result.category_filters.length; i++) {
      if (result.category_filters[i].type === "attributes") {
        result.category_filters[i].filters = await attribute_types.findByPk(
          result.category_filters[i].value,
          {
            include: { model: attribute_values, attributes: ["id", "name"] },
            attributes: ["id", "name"],
          }
        );
      }
    }

    result = result.category_filters.map((el) => {
      if (el.type === "attributes") {
        el.filters = el.filters.toJSON();

        const result = {
          ...el.filters,
          info: el.filters.attribute_values,
          type: el.type,
        };

        delete result.attribute_values;

        return result;
      } else if (el.type === "price_range") {
        const result = { ...el, info: JSON.parse(el.value) };

        delete result.value;

        return result;
      }
    });

    if (!result) return res.sendStatus(404);
  } catch (err) {
    console.log(err);
  }

  res.json(result);
}
