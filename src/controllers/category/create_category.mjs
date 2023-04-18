import { Database } from "../../database/index.mjs";
import { object, string, number } from "yup";

export const categorySchema = object()
  .shape({
    name: string(),
    hru: string(),
    parent_category_id: number().positive(),
    icon: string(),
    image: string(),
  })
  .noUnknown(true);

export async function createCategory(req, res) {
  const { body } = req;

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

  try {
    result = await category.create(validationResult);
  } catch (err) {
    res.sendStatus(500);
    console.log(err);

    return false;
  }

  res.sendStatus(201);
}
