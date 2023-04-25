import { array, number, object } from "yup";
import { Op } from "sequelize";
import { Database } from "../../database/index.mjs";

const schema = object()
  .shape({
    productId: number().required(),
    values: array().of(number().required()).required(),
  })
  .noUnknown(true);

export async function addAttributeValuesToProduct(req, res) {
  let validData;

  try {
    validData = await schema.validate({ ...req.params, ...req.body });
  } catch (error) {
    console.error(error);
    return res.sendStatus(400);
  }

  const db = Database().getInstance();

  const { product_attributes, attribute_values } = db.models;

  let result;

  try {
    result = await attribute_values.findAll({
      where: {
        id: {
          [Op.in]: validData.values,
        },
      },
    });

    if (result.length !== validData.values.length) {
      return res.sendStatus(400);
    }

    result = await product_attributes.bulkCreate(
      result.map((item) => ({
        product_id: validData.productId,
        product_attribute_value_id: item.id,
      }))
    );
  } catch (error) {
    if (error.name === "SequelizeUniqueConstraintError") {
      if (
        error.parent.constraint ===
        "product_attributes_product_id_product_attribute_value_id"
      ) {
        return res
          .status(400)
          .json({ message: "Product already has this attribute value" });
      }
    }

    return res.sendStatus(500);
  }

  return res.status(201).json(result);
}
