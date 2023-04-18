import { Database } from "../../database/index.mjs";
import { categorySchema } from "./create_category.mjs";

export async function changeCategory(req, res) {
  const {
    body,
    params: { id },
  } = req;

  let validationResult;

  try {
    validationResult = await categorySchema.validate(body);
  } catch (err) {
    console.error(err);
    res.sendStatus(400);
    return;
  }

  const db = Database().getInstance();

  const { category } = db.models;

  let result = null;

  console.log(body);
  try {
    result = await category.update(validationResult, {
      where: {
        id: parseInt(id),
      },
    });
  } catch (err) {
    console.log(err);
  }

  res.sendStatus(200);
}
