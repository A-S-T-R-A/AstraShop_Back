import fs from "fs";
import path from "path";
import * as url from "url";

export const __dirname = url.fileURLToPath(new URL(".", import.meta.url));

export function Router() {
  return Object.freeze({
    async start(app) {
      const routeFiles = await fs
        .readdirSync(path.join(__dirname))
        .filter((name) => !name.endsWith(".mjs"));

      const routeModules = await Promise.all(
        routeFiles.map((name) =>
          import(path.join(__dirname, name, "index.mjs"))
        )
      );

      routeModules.forEach((module) => {
        module = module.default();

        const path = module.getPath();
        const methods = module.getMethods();

        for (let methodName in methods) {
          app[methodName](path, methods[methodName]);
        }
      });
    },
  });
}
