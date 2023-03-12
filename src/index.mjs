import express from "express";
import { Database } from "./database/index.mjs";
import { Router } from "./routes/index.mjs";

const app = express();

app.use(express.json());

const router = Router(app);
const database = Database();

app.listen(3000, () => {
  database.start();

  router.start(app);
});
