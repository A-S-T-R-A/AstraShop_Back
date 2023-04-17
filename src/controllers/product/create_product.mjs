import { Database } from "../../database/index.mjs";
import { number, object, string } from "yup";

export const productSchema = object()
  .shape({
    name: string(),
    price: number().positive(),
    description: string(),
    parent_category_id: number().positive(),
  })
  .noUnknown(true);

export async function createProduct(req, res) {
  const db = Database().getInstance();

  const { product } = db.models;

  let validationResult;

  try {
    validationResult = await productSchema.validate(req.body);
  } catch (err) {
    console.error(err);
    res.sendStatus(400);
    return;
  }

  const { name, description, price, parent_category_id } = req.body;

  let result;

  try {
    result = await product.create({
      name,
      description,
      price,
      parent_category_id,
    });
  } catch (error) {
    console.log(error);
    return res.sendStatus(500);
  }

  res.status(201).json(result);
}
