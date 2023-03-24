import { Database } from "../../database/index.mjs";

export async function createOrder(req, res) {
  const db = Database().getInstance();
  const { product_id } = req.body;

  const { orders } = db.models;

  let result;

  try {
    result = await orders.create({ product_id });
  } catch (err) {
    console.log(err);
  }

  res.json(result);
}
