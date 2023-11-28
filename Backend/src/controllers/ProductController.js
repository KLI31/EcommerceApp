// src/controllers/productController.js
const ProductModel = require('../models/ProductModel');

const ProductController = {
  getAllProducts: function(req, res) {
    ProductModel.getAll(function(err, results) {
      if (err) {
        res.status(500).send('Error en el servidor');
      } else {
        res.status(200).json(results);
      }
    });
  },
  // Agrega aquí más métodos de controlador según sea necesario
};

module.exports = ProductController;
