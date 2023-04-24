import { number, object } from "yup";
import { Database } from "../../database/index.mjs";

const schema = object()
  .shape({
    categoryId: number().required(),
    attributeId: number().required(),
  })
  .noUnknown(true);

export async function getAllCategoryAttributesValues(req, res) {
  let validData;

  try {
    validData = await schema.validate(req.params);
  } catch (error) {
    console.error(error);
    return res.sendStatus(400);
  }

  const db = Database().getInstance();

  const { attribute_types, attribute_values } = db.models;

  let result;

  try {
    result = await attribute_types.findAll({
      include: [
        {
          model: attribute_values,
          attributes: ["id", "name"],
          where: {
            attribute_type_id: validData.attributeId,
          },
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
