const express = require('express');
const jwt = require('jsonwebtoken');
const db = require('../config/db');

const router = express.Router();

// Ruta de registro
router.post('/register', async (req, res) => {
    try {
        const { Primer_nombre, Primer_Apellido, Contraseña, Correo_Electronico } = req.body;
        const sql = 'INSERT INTO usuario (Primer_nombre, Primer_Apellido, Contraseña, Correo_Electronico) VALUES (?, ?, ?, ?)';
        db.query(sql, [Primer_nombre, Primer_Apellido, Contraseña, Correo_Electronico], (err, result) => {
            if (err) {
                console.log(err);
                return res.status(500).send('Error en el servidor');
            }
            res.status(201).send('Usuario registrado con éxito');
        });
    } catch (error) {
        res.status(500).send('Error en el servidor');
    }
});

// Ruta de inicio de sesión
router.post('/login', async (req, res) => {
    const { Correo_Electronico, Contraseña } = req.body;

    if (!Correo_Electronico || !Contraseña) {
        return res.status(400).send('Correo electrónico y Contraseña son requeridos');
    }

    const sql = 'SELECT * FROM usuario WHERE Correo_Electronico = ?';
    db.query(sql, [Correo_Electronico], (err, results) => {
        if (err) {
            console.error('Error durante la consulta a la base de datos:', err);
            return res.status(500).send('Error en el servidor');
        }

        if (results.length === 0) {
            console.log('No se encontró el usuario');
            return res.status(401).send('Credenciales incorrectas');
        }

        if (Contraseña !== results[0].Contraseña) {
            return res.status(401).send('Credenciales incorrectas');
        }
        const user = results[0];
        const token = jwt.sign({ id: user.id_user }, process.env.JWT_SECRET, { expiresIn: '1h' });

        res.json({
            token,
            userData: {
                id: user.id_user,
                Primer_nombre: results[0].Primer_nombre,
                Primer_Apellido: results[0].Primer_Apellido
            }
        });
    });
});


// Ruta para obtener todos los usuarios
router.get('/usuarios', (req, res) => {
    const sql = 'SELECT correo_electronico FROM usuario';
    db.query(sql, (err, results) => {
        if (err) {
            res.status(500).send('Error al obtener los usuarios');
        } else {
            res.status(200).json(results);
        }
    });
});





module.exports = router;