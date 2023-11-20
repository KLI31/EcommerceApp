const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const db = require('../config/db');

const router = express.Router();

// Ruta de registro
router.post('/register', async (req, res) => {
    try {
        const { Primer_nombre, Primer_Apellido, Contraseña, Correo_Electronico } = req.body;
        const hashedPassword = await bcrypt.hash(Contraseña, 10);

        const sql = 'INSERT INTO usuario (Primer_nombre, Primer_Apellido, Contraseña, Correo_Electronico) VALUES (?, ?, ?, ?)';
        console.log('Solicitud recibida para crear usuarios');
        db.query(sql, [Primer_nombre, Primer_Apellido, hashedPassword, Correo_Electronico], (err, result) => {
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
router.post('/login', (req, res) => {
    const { Correo_Electronico, Contraseña } = req.body;

    if (!Correo_Electronico || !Contraseña) {
        return res.status(400).send('Correo electrónico y Contraseña son requeridos');
    }

    console.log('Solicitud recibida para iniciar sesión con:', Correo_Electronico);

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

        // Compara las contraseñas en texto plano
        if (Contraseña !== results[0].Contraseña) {
            return res.status(401).send('Credenciales incorrectas');
        }

        const token = jwt.sign({ id: results[0].id }, process.env.JWT_SECRET, { expiresIn: '1h' });
        res.status(200).json({ message: 'Inicio de sesión exitoso', token });
    });
});



// Ruta para obtener todos los usuarios
router.get('/usuarios', (req, res) => {
    const sql = 'SELECT correo_electronico FROM usuario';
    db.query(sql, (err, results) => {
        if (err) {
            res.status(500).send('Error al obtener los usuarios');
        } else {
            // Enviar los resultados
            res.status(200).json(results);
        }
    });
});





module.exports = router;