import { Database } from "../../database/index.mjs";

export async function getProductById(req, res) {
  const sequelize = Database();
  const db = sequelize.getInstance();

  const {
    params: { id },
  } = req;

  const { product } = db.models;

  let result;

  try {
    result = await product.findByPk(id);

    if (!result) {
      res.sendStatus(404);
      return;
    }

    const parentCategories = await db.query(
      `
      WITH RECURSIVE category_tree AS (
        SELECT id, parent_category_id, name
        FROM category
        WHERE id = (SELECT parent_category_id FROM product WHERE id = ${id})
        UNION ALL
        SELECT c.id, c.parent_category_id, c.name
        FROM category c
        JOIN category_tree ct ON c.id = ct.parent_category_id
      )
      
      SELECT * from category_tree
      ORDER BY parent_category_id DESC
      `
    );

    result = JSON.parse(JSON.stringify(result));
    result.parentCategories = parentCategories[0];
  } catch (err) {
    console.log(err);
  }

  res.json(result);
}
