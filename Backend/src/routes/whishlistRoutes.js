const express = require('express')
const db = require('../config/db');

const router = express.Router();



router.get("/wishlist/:userId", (req, res) => {
    const userId = req.params.userId;
    db.query("SELECT wl.*, p.Nombre, p.Precio, p.Descripcion, p.img1, p.img2, p.img3 FROM wishlist wlJOIN productos p ON wl.id_prenda = p.idWHERE wl.id_user = ?", [userId], (err, results) => {
        if (err) {
            console.log(err)
            return res.status(500).send("Error en el servidor");
        } else {
            res.json({ data: results })
        }
    })
})


router.post("/whish", (req, res) => {
    const { id_user, id_prenda } = req.body;
    db.query('INSERT INTO wishlist (id_user, id_prenda) VALUES (?, ?)', [id_user, id_prenda], (error, results) => {
        if (error) {
            console.log(error);
            return res.status(500).json({ error });
        }
        const id_wishlist = results.insertId
        res.status(201).json({ message: 'Artículo añadido a la wishlist', data: results, id_wishlist: id_wishlist });
    });
});



router.delete('/wishlist/:wishlistId', (req, res) => {
    const wishlistId = req.params.wishlistId;
    db.query('DELETE FROM wishlist WHERE id_wishlist = ?', [wishlistId], (error, results) => {
        if (error) {
            return res.status(500).json({ error });
        }
        if (results.affectedRows === 0) {
            return res.status(404).json({ message: 'Artículo no encontrado en la wishlist' });
        }
        res.json({ message: 'Artículo eliminado de la wishlist' });
    });
});


module.exports = router;