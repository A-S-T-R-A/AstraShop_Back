import { object, string, number } from "yup";
import { Database } from "../../database/index.mjs";

const schema = object().shape({
  name: string().required(),
  categoryId: number().required(),
  attributeId: number().required(),
});

export async function updateCategoryAttribute(req, res) {
  const { categoryId, attributeId } = req.params;

  let validData;

  try {
    validData = await schema.validate({ ...req.body, categoryId, attributeId });
  } catch (error) {
    console.error(error);
    return res.sendStatus(400);
  }

  const db = Database().getInstance();

  const { attribute_types } = db.models;

  let result;

  try {
    result = await attribute_types.update(
      {
        name: validData.name,
      },
      {
        where: {
          id: validData.attributeId,
        },
      }
    );
  } catch (error) {
    console.error(error);
    return res.sendStatus(500);
  }

  return res.status(200).json(result);
}
