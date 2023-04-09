import { Database } from "../../database/index.mjs";

const order_dict = {
  low_price: "ASC",
  high_price: "DESC",
};

export async function getCategoryProducts(req, res) {
  const db = Database().getInstance();

  const {
    params: { id },
    query: { orderBy },
  } = req;

  const { category, product } = db.models;

  let result;

  const params = {
    include: {
      model: product,
      attributes: ["price"],
    },
    attributes: ["parent_category_id", "id", "name", "image", "icon", "hru"],
  };

  if (orderBy) {
    if (
      !Object.keys(order_dict).some((key) => {
        if (key === orderBy) {
          return true;
        }
      })
    ) {
      res.sendStatus(400);
      return;
    }

    params.order = [[product, "price", order_dict[orderBy]]];
  }

  try {
    result = await category.findByPk(id, params);

    if (!result) {
      res.sendStatus(404);
      return;
    }
  } catch (err) {
    console.log(err);
  }

  res.json(result);
}
