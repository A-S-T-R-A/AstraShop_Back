import { Database } from "../../database/index.mjs";

export async function getProductById(req, res) {
  const sequelize = Database();
  const db = sequelize.getInstance();

  const {
    params: { id },
  } = req;

  const {
    product,
    product_attributes,
    attribute_types,
    attribute_values,
    category,
  } = db.models;

  let result;

  try {
    result = await product.findByPk(id, {
      include: [
        {
          model: product_attributes,
          attributes: ["id"],
          include: {
            required: true,
            attributes: ["id", "name"],
            model: attribute_values,
            include: {
              attributes: ["id", "name"],
              model: attribute_types,
            },
          },
        },
        {
          model: category,
          attributes: ["id", "name"],
        },
      ],
      attributes: ["id", "name", "description", "price", "images"],
    });

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

    result = result.toJSON();

    const attributes = {};

    result.product_attributes.forEach((el) => {
      const value = el.attribute_value;
      const type = value.attribute_type;

      if (!attributes[type.id]) {
        attributes[type.id] = {
          [type.name]: [],
        };
      }

      attributes[type.id][type.name].push({ id: value.id, name: value.name });
    });

    result.attributes = Object.values(attributes);

    delete result.product_attributes;

    result.parentCategories = parentCategories[0];
  } catch (err) {
    console.log(err);
  }

  res.json(result);
}
