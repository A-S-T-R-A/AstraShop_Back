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
      sequelize = new Sequelize(
        config.development.database,
        config.development.username,
        config.development.password,
        {
          host: config.development.host,
          port: config.development.port,
          logging: console.log,
          maxConcurrentQueries: 100,
          dialect: config.development.dialect,
          dialectOptions: {
            ssl: {
              ca: fs.readFileSync("./cert/eu-central-1-bundle.pem"),
            },
          },
          pool: { maxConnections: 5, maxIdleTime: 30 },
          language: "en",
        }
      );

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
        attribute_values,
        attribute_types,
        product_attributes,
        order_products,
        orders,
        category_attributes,
      } = sequelize.models;

      category.hasMany(product, {
        foreignKey: "parent_category_id",
      });

      product.belongsTo(category, {
        foreignKey: "parent_category_id",
      });

      attribute_types.hasMany(attribute_values, {
        foreignKey: "attribute_type_id",
        onDelete: "cascade", // delete all associated attribute values when attribute type is deleted. If you want to change you need to create migration
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

      product.hasMany(order_products, {
        foreignKey: "product_id",
      });

      order_products.belongsTo(product, {
        foreignKey: "product_id",
      });

      orders.hasMany(order_products, {
        foreignKey: "order_id",
      });

      order_products.belongsTo(orders, {
        foreignKey: "order_id",
      });

      category.hasMany(category_attributes, {
        foreignKey: "category_id",
      });

      category_attributes.belongsTo(category, {
        foreignKey: "category_id",
      });

      attribute_types.hasMany(category_attributes, {
        foreignKey: "attribute_type_id",
        onDelete: "cascade", // delete all associated attribute values when attribute type is deleted. If you want to change you need to create migration
      });

      category_attributes.belongsTo(attribute_types, {
        foreignKey: "attribute_type_id",
      });
    },
    getInstance() {
      return sequelize;
    },
  });

  return database;
}
