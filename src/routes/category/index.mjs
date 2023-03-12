import { Database } from "../../database/index.mjs";
import { RouterModule } from "../../modules/router.mjs";

export default function Category() {
  const database = Database();

  const route = Object.freeze({
    ...RouterModule(),
    getMethods() {
      return {
        get(req, res) {
          res.send(200);
        },
      };
    },
  });

  route.setPath("/category");

  return route;
}
