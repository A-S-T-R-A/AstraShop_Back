import { Database } from "../../database/index.mjs";
import { array, number, object, string } from "yup";

const schema = object()
  .shape({
    name: string().required(),
    categoryId: number().required(),
    values: array().of(
      object().shape({
        name: string().required(),
      })
    ),
  })
  .noUnknown(true);

export async function createCategoryAttribute(req, res) {
  const { categoryId } = req.params;

  let validData;

  try {
    validData = await schema.validate({ ...req.body, categoryId });
  } catch (error) {
    console.error(error);
    return res.sendStatus(400);
  }

  const db = Database().getInstance();

  const { category_attributes, attribute_types, attribute_values } = db.models;

  let result;

  try {
    const queryParams = {
      name: validData.name,
      category_attributes: {
        category_id: validData.categoryId,
      },
    };

    if (validData.values) {
      queryParams.attribute_values = validData.values.map((value) => ({
        name: value.name,
      }));
    }

    result = await attribute_types.create(queryParams, {
      include: [category_attributes, attribute_values],
    });
  } catch (error) {
    console.error(error);
    return res.sendStatus(500);
  }

  return res.status(200).json(result);
}
