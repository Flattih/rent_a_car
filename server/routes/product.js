const express = require("express");
const productRouter = express.Router();
const auth = require("../middlewares/auth");
const Product = require("../models/product");

// add product
productRouter.post("/api/add-product", auth, async (req, res) => {
  try {
    const { name, description, images, quantity, price, category } = req.body;
    let product = new Product({
      userId: req.user,
      name,
      description,
      images,
      quantity,
      price,
      category,
    });
    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
// Delete the product
productRouter.post("/api/delete-product", auth, async (req, res) => {
  try {
    const {id,productId} = req.body;
    console.log(id);
    console.log(productId);
    const post = await Product.findById(productId);
    if (post.userId ===id) {
      await Product.deleteOne();
      res.status(200).json("Post silindi!");
    } else {
      res.status(403).json("Sadece kendi postlarını silebilirsin!");
    }
   
  } catch (e) {
    
    res.status(500).json({ error: e.message });
  }
});
  // search product
productRouter.get("/api/products/search/:name", auth, async (req, res) => {

  try {console.log("istek");
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });

    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get products by date
productRouter.get("/api/get-products", auth, async (req, res) => {
  try {
    const products = await Product.find({})
      .sort("-date")
      .exec((err, docs) => {
        res.json(docs);
      });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productRouter.get("/api/products", auth, async (req, res) => {
  try {
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
module.exports = productRouter;
