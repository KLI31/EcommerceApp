// src/models/ProductModel.js
const db = require('../config/db');

const ProductModel = {
  getAll: function(callback) {
    return db.query('SELECT * FROM prenda', callback);
  },
  // Agrega aquí más métodos según sea necesario
};

module.exports = ProductModel;
