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
    },
    getInstance() {
      return sequelize;
    },
  });

  return database;
}
