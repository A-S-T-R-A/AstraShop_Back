import { array, boolean, number, object, string } from "yup";
import { Database } from "../../database/index.mjs";

const schema = object()
  .shape({
    isExisted: boolean(),
    id: number(),
    data: object()
      .shape()
      .when("isExisted", {
        is: true,
        then: () =>
          object().shape({
            id: number().required(),
          }),
        otherwise: () =>
          object().shape({
            name: string().required(),
          }),
      })
      .required(),
    values: array().of(
      object().shape({
        isExisted: boolean(),
        id: number().required(),
        data: object()
          .shape()
          .when("isExisted", {
            is: true,
            then: () =>
              object().shape({
                id: number().required(),
              }),
            otherwise: () =>
              object().shape({
                name: string().required(),
              }),
          })
          .required(),
      })
    ),
  })
  .noUnknown(true);

export async function updateProductAttributes(req, res) {
  let validData;

  try {
    validData = await schema.validate(req.body);
  } catch (error) {
    console.error(error);
    return res.sendStatus(400);
  }

  const db = Database().getInstance();

  if (validData.id) {
    const { attribute_types } = db.models;

    let result;

    if (!validData.isExisted) {
      try {
        result = await attribute_types.update(
          {
            name: validData.data.name,
          },
          {
            where: {
              id: validData.id,
            },
          }
        );
      } catch (error) {
        console.error(error);
        return res.sendStatus(500);
      }
    }
  }

  if (validData.values) {
    const { attribute_values } = db.models;

    validData.values.forEach(async (value) => {
      let result;

      if (!value.isExisted) {
        try {
          result = await attribute_values.update(
            {
              name: value.data.name,
            },
            {
              where: {
                id: value.id,
              },
            }
          );
        } catch (error) {
          console.error(error);
          return res.sendStatus(500);
        }
      }
    });
  }

  res.sendStatus(200);
}
