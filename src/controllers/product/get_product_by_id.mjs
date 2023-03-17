import { Database } from "../../database/index.mjs";

export async function getProductById(req, res) {
  const db = Database().getInstance();

  const {
    params: { id },
  } = req;

  const { product } = db.models;

  let result;

  try {
    result = await product.findByPk(id);
  } catch (err) {
    console.log(err);
  }

  res.json(result);
}
