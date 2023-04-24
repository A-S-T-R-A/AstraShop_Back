import { number, object, string } from "yup";
import { Database } from "../../database/index.mjs";

const schema = object()
  .shape({
    categoryId: number().required(),
    attributeId: number().required(),
    valueId: number().required(),
    name: string().required(),
  })
  .noUnknown(true);

export async function updateValue(req, res) {
  let validData;

  try {
    validData = await schema.validate({ ...req.params, ...req.body });
  } catch (error) {
    console.error(error);
    return res.sendStatus(400);
  }

  const db = Database().getInstance();

  const { attribute_values } = db.models;

  let result;

  try {
    result = await attribute_values.update(
      {
        name: validData.name,
      },
      {
        where: {
          id: validData.valueId,
        },
      }
    );
  } catch (error) {
    console.error(error);
    return res.sendStatus(500);
  }

  return res.status(200).json(result);
}
