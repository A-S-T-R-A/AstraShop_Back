import { Database } from "../../database/index.mjs";

export async function createCategory(req, res) {
  const { body } = req;

  const db = Database().getInstance();

  const { category } = db.models;

  let result = null;

  try {
    result = await category.create({ name: body.name });
  } catch (err) {
    res.sendStatus(409);
    console.log(err);

    return false;
  }

  res.sendStatus(201);
}
