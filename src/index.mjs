import express from "express";
import { createCategory } from "./controllers/category/create_category.mjs";
import { changeCategory } from "./controllers/category/change_category.mjs";
import { Database } from "./database/index.mjs";
import { getCategoryTree } from "./controllers/category/get_tree.mjs";
import { getProductById } from "./controllers/product/get_product_by_id.mjs";
import { getCategoryProducts } from "./controllers/category/get_category_products.mjs";
import { getTopProducts } from "./controllers/product/get_top_products.mjs";
import { getNewProducts } from "./controllers/product/get_new_products.mjs";
import { getCategoryFilters } from "./controllers/category/get_category_filters.mjs";
import fs from "fs";
import path from "path";
import https from "https";
import { createOrder } from "./controllers/order/create_order.mjs";
import { getAllOrders } from "./controllers/order/get_all_orders.mjs";
import * as url from "url";
export const __dirname = url.fileURLToPath(new URL(".", import.meta.url));

const app = express();

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-Methods",
    "GET, POST, OPTIONS, PUT, PATCH, DELETE"
  );
  res.header("Access-Control-Allow-Headers", "content-type,Authorization");
  next();
});

app.use(express.json());
app.use("/static", express.static(path.join(__dirname, "views", "static")));

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

app.get("/api/v1/category/:id/filters", getCategoryFilters);

app.post("/api/v1/order", createOrder);
app.get("/api/v1/order", getAllOrders);

app.get("/", function (req, res) {
  res.sendFile(path.join(__dirname, "views", "index.html"));
});

app.get("/success_payment", function (req, res) {
  res.sendFile(path.join(__dirname, "views", "success_payment.html"));
});

app.get("/cancel_payment", function (req, res) {
  res.sendFile(path.join(__dirname, "views", "cancel_payment.html"));
});

const options = {
  ca: fs.readFileSync(path.resolve("cert", "ca_bundle.crt")),
  key: fs.readFileSync(path.resolve("cert", "private.key")),
  cert: fs.readFileSync(path.resolve("cert", "certificate.crt")),
};

https.createServer(options, app).listen(3000);

const database = Database();

database.start();
