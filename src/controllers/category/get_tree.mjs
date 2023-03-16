import { Database } from "../../database/index.mjs";

function buildTree(arr, parent = null) {
  const tree = [];
  for (const item of arr) {
    if (item.parent_category_id === parent) {
      const children = buildTree(arr, item.id);
      if (children.length) {
        item.children = children;
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
      raw: true,
      order: [["parent_category_id", "NULLS FIRST"]],
      attributes: ["parent_category_id", "id", "name"],
    });
  } catch (err) {
    console.log(err);
  }

  result = buildTree(result);

  res.json(result);
}
