import { Database } from "../../database/index.mjs";

export async function getNewProducts(req, res) {
  const db = Database().getInstance();

  const { product } = db.models;

  let result;

  try {
    result = await product.findAll({
      where: {
        is_new: true,
      },
    });
  } catch (err) {
    console.log(err);
  }

  res.json(result);
}
