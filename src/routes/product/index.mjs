import { Database } from "../../database/index.mjs";
import { openDatabase } from "../../modules/open_data_base.mjs";
import { RouterModule } from "../../modules/router.mjs";

export default function Product() {
  const database = Database().getInstance();

  const route = Object.freeze({
    ...RouterModule(),
  });

  const { product } = database.models;

  route.setPath("/product");

  route.setMethods(openDatabase(product));

  return route;
}
