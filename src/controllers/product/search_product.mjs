import { Database } from "../../database/index.mjs";

export async function searchProduct(req, res) {
  const db = Database().getInstance();

  const { name } = req.query;

  let result;

  try {
    result = await db.query(`
      SELECT product.id, product.name, array_agg(attribute_values.name) as attributes
      FROM product
      LEFT JOIN product_attributes ON product.id = product_attributes.product_id
      LEFT JOIN attribute_values ON product_attributes.product_attribute_value_id = attribute_values.id
      WHERE product.name ILIKE '%${name}%' or attribute_values.name ILIKE '%${name}%'
      GROUP BY product.id, product.name; 
    `);

    if (!result) {
      res.sendStatus(404);
      return;
    }

    result = result[0];
  } catch (err) {
    res.sendStatus(500);
    return console.log(err);
  }

  res.json(result);
}
