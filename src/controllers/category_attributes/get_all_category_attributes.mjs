import { Database } from "../../database/index.mjs";

export async function getAllCategoryAttributes(req, res) {
  const db = Database().getInstance();

  const { category_attributes, attribute_types, attribute_values } = db.models;

  let result;

  try {
    result = await category_attributes.findAll({
      include: [
        {
          model: attribute_types,
          attributes: ["id", "name"],
          include: [
            {
              model: attribute_values,
              attributes: ["id", "name"],
            },
          ],
        },
      ],
      attributes: [],
    });
  } catch (error) {
    console.error(error);
    return res.sendStatus(500);
  }

  return res.status(200).json(result);
}
