import { Database } from "../database/index.mjs";

export async function renderProductsPage(req, res) {
  const db = Database().getInstance();

  const { product } = db.models;

  let result;

  try {
    result = await product.findAll({
      attributes: ["id", "name", "description", "price", "images"],
      order: [["createdAt", "DESC"]],
    });
  } catch (error) {
    console.log(error);
  }

  res.render("admin/products", {
    products: JSON.parse(JSON.stringify(result)),
  });
}
