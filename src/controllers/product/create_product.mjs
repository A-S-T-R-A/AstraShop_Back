import { Database } from "../../database/index.mjs";

export async function createProduct(req, res) {
  const db = Database().getInstance();

  const { product } = db.models;

  const { name, description, price } = req.body;

  let result;

  try {
    result = await product.create({
      name,
      description,
      price,
    });
  } catch (error) {
    console.log(error);
    return res.sendStatus(500);
  }

  res.status(201).json(result);
}
