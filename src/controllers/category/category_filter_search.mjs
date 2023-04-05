import { Database } from "../../database/index.mjs";
import { Op } from "sequelize";

export async function categoryFilterSearch(req, res) {
  const db = Database().getInstance();

  const {
    params: { id },
  } = req;

  const { category_filters } = db.models;

  let filterResult;

  try {
    filterResult = await category_filters.findByPk(id);

    if (!filterResult) {
      res.sendStatus(404);
      return;
    }
  } catch (err) {
    res.sendStatus(500);
    return console.log(err);
  }

  let result;

  const { product, product_attributes } = db.models;
  const { query } = req;

  switch (filterResult.type) {
    case "attributes":
      const { id } = query;

      try {
        result = await product.findAll({
          where: {
            parent_category_id: filterResult.parent_category_id,
          },
          include: {
            model: product_attributes,
            where: {
              id: {
                [Op.or]: id.split(",").map((el) => parseInt(el)),
              },
            },
          },
        });
      } catch (err) {
        res.sendStatus(500);
        return console.log(err);
      }
      break;
    case "price_range":
      const { min, max } = query;

      try {
        result = await product.findAll({
          where: {
            parent_category_id: filterResult.parent_category_id,
            price: {
              [Op.between]: [min, max],
            },
          },
        });
      } catch (err) {
        res.sendStatus(500);
        return console.log(err);
      }
      break;
  }

  res.json(result);
}
