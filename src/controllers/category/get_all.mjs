import { Database } from "../../database/index.mjs";

export async function getAllCategories(req, res) {
  const db = Database().getInstance();

  const { category } = db.models;

  let result;

  try {
    result = await category.findAll({
      attributes: ["id", "name"],
    });
  } catch (error) {
    console.log(error);
  }

  res.status(200).json(result);
}
