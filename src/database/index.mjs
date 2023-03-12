import { Sequelize } from "sequelize";
import config from "./config/config.js";
import { Product } from "./models/product.mjs";

let database;

export function Database() {
  if (database) {
    return database;
  }

  let sequelize;

  database = Object.freeze({
    async start() {
      sequelize = new Sequelize(config.development);

      const productModel = Product(sequelize);

      try {
        await sequelize.authenticate();
        console.log("Connection has been established successfully.");
      } catch (error) {
        console.error("Unable to connect to the database:", error);
      }
    },
    getInstance() {
      return sequelize;
    },
  });

  return database;
}
