import { Database } from "../../database/index.mjs";

export async function getAllOrders(req, res) {
  const db = Database().getInstance();

  const { orders } = db.models;

  let result;

  try {
    result = await orders.findAll();
  } catch (err) {
    console.log(err);
  }

  res.json(result);
}
