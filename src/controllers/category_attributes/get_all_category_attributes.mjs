import { number, object } from "yup";
import { Database } from "../../database/index.mjs";

const schema = object().shape({
  categoryId: number().required(),
});

export async function getAllCategoryAttributes(req, res) {
  const { categoryId } = req.params;

  let validData;

  try {
    validData = await schema.validate({ categoryId });
  } catch (error) {
    console.error(error);
    return res.sendStatus(400);
  }

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
      where: {
        category_id: validData.categoryId,
      },
      attributes: [],
    });
  } catch (error) {
    console.error(error);
    return res.sendStatus(500);
  }

  return res.status(200).json(result);
}
