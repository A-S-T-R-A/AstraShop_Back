import { Database } from "../database/index.mjs";

export async function renderProductsPage(req, res) {
  const db = Database().getInstance();

  const { product, category } = db.models;

  let productsResult;

  try {
    productsResult = await product.findAll({
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

  let categoriesResult;

  try {
    categoriesResult = await category.findAll({
      attributes: ["id", "name"],
    });
  } catch (error) {
    console.log(error);
  }

  res.render("admin/products", {
    products: JSON.parse(JSON.stringify(productsResult)),
    categories: JSON.parse(JSON.stringify(categoriesResult)),
  });
}
