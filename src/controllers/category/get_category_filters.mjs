import { Database } from "../../database/index.mjs";

export async function getCategoryFilters(req, res) {
  const db = Database().getInstance();

  const {
    params: { id },
  } = req;

  const { category, category_filters } = db.models;

  let result;

  try {
    result = await category.findByPk(id, { include: category_filters });
  } catch (err) {
    console.log(err);
  }

  res.json(result);
}
