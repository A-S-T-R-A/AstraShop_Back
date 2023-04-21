import { Database } from "../../database/index.mjs";
import { array, boolean, number, object, string } from "yup";

export const schema = object()
  .shape({
    isExisted: boolean(),
    data: object()
      .shape({
        name: string(),
        id: number(),
      })
      .required(),
    values: array()
      .of(
        object().shape({
          isExisted: boolean(),
          data: object()
            .shape({
              name: string(),
              id: number(),
            })
            .required(),
        })
      )
      .required(),
  })
  .noUnknown(true);

export async function addAttributeToProduct(req, res) {
  let validData;

  try {
    validData = await schema.validate(req.body);
  } catch (error) {
    console.error(error);
    return res.sendStatus(400);
  }

  const db = Database().getInstance();

  const { product_attributes, attribute_types, attribute_values } = db.models;

  try {
    await db.transaction(async (t) => {
      const newType = await attribute_types.create(
        {
          name: validData.data.name,
        },
        { transaction: t }
      );

      const attributeTypeId = newType.id;

      const newValues = await attribute_values.bulkCreate(
        validData.values.map((value) => ({
          name: value.data.name,
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
