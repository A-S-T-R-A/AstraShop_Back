import express from "express";
import { createCategory } from "./controllers/category/create_category.mjs";
import { changeCategory } from "./controllers/category/change_category.mjs";
import { Database } from "./database/index.mjs";
import { getCategoryTree } from "./controllers/category/get_tree.mjs";
import { getProductById } from "./controllers/product/get_product_by_id.mjs";
import { getCategoryProducts } from "./controllers/category/get_category_products.mjs";
import { getTopProducts } from "./controllers/product/get_top_products.mjs";
import { getNewProducts } from "./controllers/product/get_new_products.mjs";

const app = express();

app.use(express.json());

const database = Database();

app.get("/api/v1/category/tree", getCategoryTree);
app.get("/api/v1/category/:id/products", getCategoryProducts);
app.post("/api/v1/category", createCategory);
app.put("/api/v1/category/:id", changeCategory);

app.get("/api/v1/product/top", getTopProducts);
app.get("/api/v1/product/new", getNewProducts);
app.get("/api/v1/product/:id", getProductById);

app.listen(3000, async () => {
  database.start();
});
