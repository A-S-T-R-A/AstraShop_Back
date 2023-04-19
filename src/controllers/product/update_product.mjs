import { Database } from "../../database/index.mjs";
import { productSchema } from "./create_product.mjs";

export async function updateProduct(req, res) {
  const db = Database().getInstance();

  const { product } = db.models;

  const { id } = req.params;

  let validationResult;

  try {
    validationResult = await productSchema.validate(req.body);
  } catch (err) {
    console.error(err);
    res.sendStatus(400);
    return;
  }

  let result;

  try {
    result = await product.update(validationResult, {
      where: {
        id,
      },
    });
  } catch (error) {
    console.log(error);
    return res.sendStatus(500);
  }

  res.sendStatus(204);
}
