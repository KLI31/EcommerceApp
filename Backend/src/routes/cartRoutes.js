const express = require('express');
const router = express.Router();
const db = require('../config/db');
const authenticateToken = require("../middleware/authenticateToken")

router.post('/cart', authenticateToken, (req, res) => {
    const { userId, productId, cantidad } = req.body;
    const checkQuery = 'SELECT * FROM carrito WHERE id_user = ? AND id_prenda = ?';
    db.query(checkQuery, [userId, productId], (error, results) => {
        if (error) {
            return res.status(500).json({ error });
        }
        if (results.length > 0) {
            const updateQuery = 'UPDATE carrito SET cantidad = cantidad + ? WHERE id_user = ? AND id_prenda = ?';
            db.query(updateQuery, [cantidad, userId, productId], (error, results) => {
                if (error) {
                    return res.status(500).json({ error });
                }
                res.status(200).json({ message: 'Cantidad actualizada en el carrito' });
            });
        } else {
            const insertQuery = 'INSERT INTO carrito (id_user, id_prenda, cantidad) VALUES (?, ?, ?)';
            db.query(insertQuery, [userId, productId, cantidad], (error, results) => {
                if (error) {
                    return res.status(500).json({ error });
                }
                res.status(201).json({ message: 'Producto añadido al carrito', id_carrito: results.insertId });
            });
        }
    });
});




router.get("/cart/:userId", (req, res) => {
    const userId = req.params.userId;
    db.query("SELECT c.*, p.Nombre, p.Precio, p.Descripcion, p.img1, p.img2, p.img3 FROM carrito c JOIN prenda p ON c.id_prenda = p.id_prenda WHERE c.id_user = ?", [userId], (err, results) => {
        if (err) {
            console.error('Error en el servidor:', err);
            return res.status(500).send("Error en el servidor");
        } else {
            res.json({ data: results });
        }
    });
});



router.delete('/cart/:userId/:productId', authenticateToken, (req, res) => {
    const { userId, productId } = req.params;
    const query = 'DELETE FROM carrito WHERE id_user = ? AND id_prenda = ?';

    db.query(query, [userId, productId], (error, results) => {
        if (error) {
            return res.status(500).json({ error });
        }
        res.json({ message: 'Producto eliminado del carrito' });
    });
});



router.put('/cart/:userId/:productId', async (req, res) => {
    const { userId, productId } = req.params;
    const { cantidad } = req.body;

    const updateQuery = `
        UPDATE carrito
        SET cantidad = ?
        WHERE id_user = ? AND id_prenda = ?
    `;

    db.query(updateQuery, [cantidad, userId, productId], (error, results) => {
        if (error) {
            console.error('Error al actualizar el carrito:', error);
            return res.status(500).json({ error: 'Error interno del servidor' });
        }

        if (results.affectedRows === 0) {
            return res.status(404).json({ message: 'Producto no encontrado en el carrito' });
        }

        res.json({ message: 'Cantidad actualizada con éxito', id_carrito: productId });
    });
});

module.exports = router;