import { array, number, object } from "yup";
import { Op } from "sequelize";
import { Database } from "../../database/index.mjs";

const schema = object()
  .shape({
    categoryId: number().required(),
    attributeId: number().required(),
    values: array().of(number()).required(),
  })
  .noUnknown(true);

export async function deleteValue(req, res) {
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
    result = await attribute_values.destroy({
      where: {
        id: {
          [Op.in]: validData.values,
        },
      },
    });
  } catch (error) {
    console.error(error);
    return res.sendStatus(500);
  }

  return res.status(200).json(result);
}
