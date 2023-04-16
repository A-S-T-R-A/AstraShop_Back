import { Database } from "../../database/index.mjs";

export async function deleteProduct(req, res) {
  const db = Database().getInstance();

  const { product } = db.models;

  const { id } = req.params;

  let result;

  try {
    result = await product.destroy({
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
