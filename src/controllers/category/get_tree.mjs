import { Database } from "../../database/index.mjs";

function buildTree(arr, parent = null) {
  const tree = [];

  for (const item of arr) {
    if (item.parent_category_id === parent) {
      const categories = buildTree(arr, item.id);

      if (categories.length) {
        item.categories = categories;
      }

      tree.push(item);
    }
  }
  return tree;
}

export async function getCategoryTree(req, res) {
  const db = Database().getInstance();

  const { category } = db.models;

  let result;

  try {
    result = await category.findAll({
      order: [["parent_category_id", "NULLS FIRST"]],
      attributes: ["parent_category_id", "id", "name", "image", "icon", "hru"],
    });
  } catch (err) {
    console.log(err);
  }

  result = buildTree(JSON.parse(JSON.stringify(result)));

  res.json(result);
}
