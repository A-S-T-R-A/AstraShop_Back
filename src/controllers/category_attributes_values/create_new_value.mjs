import { number, object, string } from "yup";
import { Database } from "../../database/index.mjs";

const schema = object()
  .shape({
    categoryId: number().required(),
    attributeId: number().required(),
    name: string().required(),
  })
  .noUnknown(true);

export async function createNewValue(req, res) {
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
    result = await attribute_values.create({
      name: validData.name,
      attribute_type_id: validData.attributeId,
    });
  } catch (error) {
    console.error(error);
    return res.sendStatus(500);
  }

  return res.status(201).json(result);
}
