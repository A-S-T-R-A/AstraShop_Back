import { Sequelize } from "sequelize";
import config from "./config/config.js";
import fs from "fs";
import path from "path";
import * as url from "url";

export const __dirname = url.fileURLToPath(new URL(".", import.meta.url));

let database;

export function Database() {
  if (database) {
    return database;
  }

  let sequelize;

  database = Object.freeze({
    async start() {
      sequelize = new Sequelize(config.development);

      try {
        await sequelize.authenticate();
        console.log("Connection has been established successfully.");
      } catch (error) {
        console.error("Unable to connect to the database:", error);
      }

      const p = [__dirname, "models"];

      const modelFiles = await fs.readdirSync(path.join(...p));

      await Promise.all(
        modelFiles.map(async (name) => {
          const m = await import(path.join(...p, name));
          const model =
            m[
              name.split(".")[0].charAt(0).toUpperCase() +
                name.split(".")[0].slice(1)
            ];

          model(sequelize);

          return model;
        })
      );

      const {
        product,
        category,
        category_filters,
        attribute_values,
        attribute_types,
        product_attributes,
      } = sequelize.models;

      category.hasMany(product, {
        foreignKey: "parent_category_id",
      });

      product.belongsTo(category, {
        foreignKey: "parent_category_id",
      });

      category.hasMany(category_filters, {
        foreignKey: "parent_category_id",
      });

      category_filters.belongsTo(category, {
        foreignKey: "parent_category_id",
      });

      attribute_types.hasMany(attribute_values, {
        foreignKey: "attribute_type_id",
      });

      attribute_values.belongsTo(attribute_types, {
        foreignKey: "attribute_type_id",
      });

      product.hasMany(product_attributes, {
        foreignKey: "product_id",
      });

      product_attributes.belongsTo(product, {
        foreignKey: "product_id",
      });

      attribute_values.hasMany(product_attributes, {
        foreignKey: "product_attribute_value_id",
      });

      product_attributes.belongsTo(attribute_values, {
        foreignKey: "product_attribute_value_id",
      });
    },
    getInstance() {
      return sequelize;
    },
  });

  return database;
}
