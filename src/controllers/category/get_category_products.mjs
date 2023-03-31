import { Database } from "../../database/index.mjs";

export async function getCategoryProducts(req, res) {
  const db = Database().getInstance();

  const {
    params: { id },
  } = req;

  const { category, product } = db.models;

  let result;

  try {
    result = await category.findByPk(id, {
      include: product,
      attributes: ["parent_category_id", "id", "name", "image", "icon", "hru"],
    });
  } catch (err) {
    console.log(err);
  }

  res.json(result);
}
