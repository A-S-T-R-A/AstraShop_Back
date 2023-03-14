import { Database } from "../../database/index.mjs";
import { openDatabase } from "../../modules/open_data_base.mjs";
import { RouterModule } from "../../modules/router.mjs";

export default function Product() {
  const database = Database().getInstance();

  const route = Object.freeze({
    ...RouterModule(),
  });

  const { product } = database.models;

  route.setPath("/product/:id?");

  const methods = openDatabase(product);

  route.setMethods({
    async get(req, res) {
      const result = await methods.get(req);
      res.json(result);
    },
  });

  return route;
}
