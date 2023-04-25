import { number, object } from "yup";
import { Database } from "../../database/index.mjs";

const schema = object()
  .shape({
    productId: number().required(),
  })
  .noUnknown(true);

export async function getAllProductAttributes(req, res) {
  let validData;

  try {
    validData = await schema.validate(req.params);
  } catch (error) {
    console.error(error);
    return res.sendStatus(400);
  }

  const db = Database().getInstance();

  const { product_attributes, attribute_types, attribute_values } = db.models;

  let result;

  try {
    result = await product_attributes.findAll({
      attributes: [],
      include: [
        {
          required: true,
          attributes: ["name", "id"],
          model: attribute_values,
          include: [
            {
              attributes: ["name", "id"],
              model: attribute_types,
            },
          ],
        },
      ],
      where: {
        product_id: validData.productId,
      },
    });
  } catch (error) {
    console.error(error);
    return res.sendStatus(500);
  }

  return res.status(200).json(result);
}
