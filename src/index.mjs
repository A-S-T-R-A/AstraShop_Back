import express from "express";
import { createCategory } from "./controllers/category/create_category.mjs";
import { changeCategory } from "./controllers/category/change_category.mjs";
import { Database } from "./database/index.mjs";
import { getCategoryTree } from "./controllers/category/get_tree.mjs";
import { getProductById } from "./controllers/product/get_product_by_id.mjs";
import { getCategoryProducts } from "./controllers/category/get_category_products.mjs";
import { getTopProducts } from "./controllers/product/get_top_products.mjs";
import { getNewProducts } from "./controllers/product/get_new_products.mjs";
import fs from "fs";
import path from "path";
import https from "https";

const app = express();

app.use(express.json());

app.get("/api/v1/check", (req, res) => {
  res.sendStatus(200);
});

app.get("/api/v1/category/tree", getCategoryTree);
app.get("/api/v1/category/:id/products", getCategoryProducts);
app.post("/api/v1/category", createCategory);
app.put("/api/v1/category/:id", changeCategory);

app.get("/api/v1/product/top", getTopProducts);
app.get("/api/v1/product/new", getNewProducts);
app.get("/api/v1/product/:id", getProductById);

const options = {
  ca: fs.readFileSync(path.resolve("cert", "ca_bundle.crt")),
  key: fs.readFileSync(path.resolve("cert", "private.key")),
  cert: fs.readFileSync(path.resolve("cert", "certificate.crt")),
};

https.createServer(options, app).listen(3000);

const database = Database();

database.start();
