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
    const { correo_Electronico, contraseña } = req.body;

    console.log('Solicitud recibida para iniciar sesión con:', correo_Electronico);

    const sql = 'SELECT * FROM usuario WHERE correo_Electronico = ?';
    db.query(sql, [correo_Electronico], async (err, results) => {
        if (err) {
            console.error('Error durante la consulta a la base de datos:', err);
            return res.status(500).send('Error en el servidor');
        }

        console.log('Resultado de la consulta:', results);

        if (results.length === 0) {
            console.log('No se encontró el usuario');
            return res.status(401).send('Credenciales incorrectas');
        }

        const esContraseñaCorrecta = await bcrypt.compare(contraseña, results[0].contraseña);
        console.log('Contraseña correcta:', esContraseñaCorrecta);

        if (!esContraseñaCorrecta) {
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