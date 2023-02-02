const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const productRouter = require("./routes/product");


const PORT = process.env.PORT || 2000;
const app = express();

app.use(express.json());

app.use(authRouter);
app.use(productRouter)

const DB =
  "your mongodb connection string";

mongoose
  .connect(DB)
  .then(() => {
    console.log("DB CONNECTED!");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {});
