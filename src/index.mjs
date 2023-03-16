import express from "express";
import { createCategory } from "./controllers/category/create_category.mjs";
import { changeCategory } from "./controllers/category/change_category.mjs";
import { Database } from "./database/index.mjs";
import { Router } from "./routes/index.mjs";
import { getCategoryTree } from "./controllers/category/get_tree.mjs";

const app = express();

app.use(express.json());

const database = Database();

app.get("/category/tree", getCategoryTree);
app.post("/category", createCategory);
app.put("/category/:id", changeCategory);

app.listen(3000, async () => {
  database.start();
});
