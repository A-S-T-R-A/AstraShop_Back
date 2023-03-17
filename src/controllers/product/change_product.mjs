import { Database } from "../../database/index.mjs";

export async function changeProduct(req, res) {
  const {
    body,
    params: { id },
  } = req;

  const db = Database().getInstance();

  const { product } = db.models;

  let result = null;

  try {
    result = await category.update(
      {
        name: body.name,
        parent_category_id: body.parentCategoryId,
      },
      {
        where: {
          id: parseInt(id),
        },
      }
    );
  } catch (err) {
    console.log(err);
  }

  res.sendStatus(200);
}
