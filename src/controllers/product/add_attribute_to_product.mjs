import { Database } from "../../database/index.mjs";
import { array, number, object, string } from "yup";

const schema = object()
  .shape({
    name: string().required(),
    id: number(),
    values: array()
      .of(
        object().shape({
          name: string().required(),
          id: number(),
        })
      )
      .required(),
  })
  .noUnknown(true);

export async function addAttributeToProduct(req, res) {
  let data;

  try {
    data = await schema.validate(req.body);
  } catch (error) {
    return res.sendStatus(400);
  }

  const db = Database().getInstance();

  const { product_attributes, attribute_types, attribute_values } = db.models;

  try {
    await db.transaction(async (t) => {
      const newType = await attribute_types.create(
        {
          name: data.name,
        },
        { transaction: t }
      );

      const attributeTypeId = newType.id;

      const newValues = await attribute_values.bulkCreate(
        data.values.map((value) => ({
          name: value.name,
          attribute_type_id: attributeTypeId,
        })),
        { transaction: t }
      );

      const { id: productId } = req.params;

      const newProductAttributes = await product_attributes.bulkCreate(
        newValues.map((value) => ({
          product_id: parseInt(productId),
          product_attribute_value_id: value.id,
        })),
        { transaction: t }
      );
    });
  } catch (error) {
    console.error(error);
    return res.sendStatus(500);
  }

  res.sendStatus(201);
}
