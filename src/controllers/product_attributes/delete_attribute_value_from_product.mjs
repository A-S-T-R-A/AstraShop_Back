import { array, number, object, string } from "yup";
import { Op } from "sequelize";
import { Database } from "../../database/index.mjs";

const schema = object()
  .shape({
    productId: number().required(),
    values: array().of(string().required()).required(),
  })
  .noUnknown(true);

export async function deleteProductAttributeValues(req, res) {
  let validData;

  try {
    validData = await schema.validate({ ...req.params, ...req.body });
  } catch (error) {
    console.error(error);
    return res.sendStatus(400);
  }

  const db = Database().getInstance();

  const { product_attributes } = db.models;

  let result;

  try {
    result = await product_attributes.destroy({
      where: {
        product_attribute_value_id: {
          [Op.in]: validData.values,
        },
        product_id: {
          [Op.eq]: validData.productId,
        },
      },
    });
  } catch (error) {
    console.error(error);
    return res.sendStatus(500);
  }

  return res.sendStatus(200);
}
