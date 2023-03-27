import { Database } from "../../database/index.mjs";
import { Op } from "sequelize";

export async function categoryFilterSearch(req, res) {
  const db = Database().getInstance();

  const {
    params: { id },
    query: { type },
    query,
  } = req;

  const { category, product } = db.models;

  let result;

  switch (type) {
    case "attributes":
      try {
        result = await category.findByPk(id, {
          include: product,
        });

        const { attributes: queryAttributes } = query;

        if (typeof queryAttributes === "undefined") {
          console.log("Attributes not found");
          return res.sendStatus(400);
        }

        let attributes;

        try {
          attributes = JSON.parse(queryAttributes);
        } catch (err) {
          console.log("Attributes not valid");
          return res.sendStatus(400);
        }

        const products = JSON.parse(JSON.stringify(result.products)).filter(
          (el) => {
            for (let key in attributes) {
              if (el?.attributes?.[key] == attributes[key]) {
                return true;
              }
            }
          }
        );

        res.json(products);
      } catch (err) {
        res.sendStatus(500);
        return console.log(err);
      }

      break;

    case "range":
      try {
        const { min, max } = query;

        if (typeof min === "undefined" || typeof max === "undefined") {
          console.log("Min or max not valid");
          return res.sendStatus(400);
        }

        result = await category.findByPk(id, {
          include: {
            model: product,
            where: {
              price: { [Op.between]: [min, max] },
            },
          },
        });

        res.json(result);
      } catch (err) {
        console.log(err);
        return res.sendStatus(500);
      }

      break;
  }
}
