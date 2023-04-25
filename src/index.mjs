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
import { searchProduct } from "./controllers/product/search_product.mjs";
import { renderProductsPage } from "./render/products.mjs";
import { createProduct } from "./controllers/product/create_product.mjs";
import { deleteProduct } from "./controllers/product/delete_product.mjs";
import { updateProduct } from "./controllers/product/update_product.mjs";
import { uploadImages } from "./controllers/other/upload_images.mjs";
import { getAllCategoryAttributes } from "./controllers/category_attributes/get_all_category_attributes.mjs";
import { createCategoryAttribute } from "./controllers/category_attributes/create_category_attribute.mjs";
import { updateCategoryAttribute } from "./controllers/category_attributes/update_category_attribute_by_id.mjs";
import { deleteCategoryAttributeById } from "./controllers/category_attributes/delete_category_attribute_by_id.mjs";
import { getAllProducts } from "./controllers/product/get_all_products.mjs";
import { getAllCategories } from "./controllers/category/get_all.mjs";
import { getAllCategoryAttributesValues } from "./controllers/category_attributes_values/get_all_values.mjs";
import { createNewValue } from "./controllers/category_attributes_values/create_new_value.mjs";
import { updateValue } from "./controllers/category_attributes_values/update_value.mjs";
import { deleteValue } from "./controllers/category_attributes_values/delete_value.mjs";
import { getAllProductAttributes } from "./controllers/product_attributes/get_all_attributes.mjs";
import { addAttributeValuesToProduct } from "./controllers/product_attributes/add_attribute_value_to_product.mjs";
import { deleteProductAttributeValues } from "./controllers/product_attributes/delete_attribute_value_from_product.mjs";

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

app.use(
  "/uploads",
  express.static(process.env.FILE_UPLOAD_PATH || path.join(__dirname, ""))
);

app.get("/api/v1/check", (req, res) => {
  res.sendStatus(200);
});

app.get("/api/v1/category/tree", getCategoryTree);
app.get("/api/v1/category/all", getAllCategories);
app.get("/api/v1/category/:id/products", getCategoryProducts);
app.post("/api/v1/category", createCategory);
app.put("/api/v1/category/:id", changeCategory);

app.get("/api/v1/product/top", getTopProducts);
app.get("/api/v1/product/new", getNewProducts);
app.get("/api/v1/product/search", searchProduct);
app.get("/api/v1/product/all", getAllProducts);

app.post("/api/v1/product", createProduct);
app.delete("/api/v1/product/:id", deleteProduct);
app.put("/api/v1/product/:id", updateProduct);

app.get("/api/v1/product/:id", getProductById);

app.get("/api/v1/category/:categoryId/filters", getCategoryFilters);

app.post("/api/v1/order", createOrder);
app.get("/api/v1/order", getAllOrders);

app.post("/api/v1/upload/images", uploadImages);

app.get(
  "/api/v1/category/:categoryId/attributes/all",
  getAllCategoryAttributes
);
app.post("/api/v1/category/:categoryId/attributes", createCategoryAttribute);
app.put(
  "/api/v1/category/:categoryId/attributes/:attributeId",
  updateCategoryAttribute
);

app.delete(
  "/api/v1/category/:categoryId/attributes/:attributeId",
  deleteCategoryAttributeById
);

app.post(
  "/api/v1/category/:categoryId/attributes/:attributeId/values",
  createNewValue
);

app.delete(
  "/api/v1/category/:categoryId/attributes/:attributeId/values",
  deleteValue
);

app.get(
  "/api/v1/category/:categoryId/attributes/:attributeId/values/all",
  getAllCategoryAttributesValues
);

app.put(
  "/api/v1/category/:categoryId/attributes/:attributeId/values/:valueId",
  updateValue
);

app.get("/api/v1/product/:productId/attributes/all", getAllProductAttributes);
app.put("/api/v1/product/:productId/attributes", addAttributeValuesToProduct);
app.delete(
  "/api/v1/product/:productId/attributes/:attributeId",
  deleteProductAttributeValues
);

app.get("/", function (req, res) {
  res.sendFile(path.join(__dirname, "views", "index.html"));
});

app.get("/success_payment", function (req, res) {
  res.sendFile(path.join(__dirname, "views", "success_payment.html"));
});

app.get("/cancel_payment", function (req, res) {
  res.sendFile(path.join(__dirname, "views", "cancel_payment.html"));
});

app.set("views", path.join(__dirname, "views"));

app.set("view engine", "pug");

app.get("/admin/products", renderProductsPage);

const options = {
  ca: fs.readFileSync(path.resolve("cert", "ca_bundle.crt")),
  key: fs.readFileSync(path.resolve("cert", "private.key")),
  cert: fs.readFileSync(path.resolve("cert", "certificate.crt")),
};

https.createServer(options, app).listen(process.env.PORT || 3000, () => {
  console.log("Server started", process.env.PORT);
});

const database = Database();

database.start();
