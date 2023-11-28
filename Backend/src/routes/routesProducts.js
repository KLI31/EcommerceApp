// src/routes/routesProducts.js
const express = require('express');
const productController = require('../controllers/ProductController');
const authenticateToken = require('../middleware/authenticateToken');

const router = express.Router();

router.get('/', productController.getAllProducts);
// Agrega aquí más rutas según sea necesario

module.exports = router;
