import { Database } from "../../database/index.mjs";

export async function getAllProducts(req, res) {
  const db = Database().getInstance();

  const { product, category } = db.models;

  let result;

  try {
    result = await product.findAll({
      attributes: ["id", "name", "description", "price", "images"],
      include: [
        {
          model: category,
          attributes: ["id", "name"],
        },
      ],
      order: [["createdAt", "DESC"]],
    });
  } catch (error) {
    console.log(error);
  }

  return res.status(200).json(result);
}
