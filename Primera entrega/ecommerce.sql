-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-11-2023 a las 16:18:46
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ecommerce`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarStock` (IN `prendaID` INT, IN `nuevoStock` INT)   BEGIN
    UPDATE prendas SET Stock = nuevoStock WHERE id_prenda = prendaID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarProducto` (IN `nom` VARCHAR(255), IN `descripcion` TEXT, IN `precio` DECIMAL(10,2), IN `stock` INT, IN `catID` INT, IN `tallaID` INT, IN `estiloID` INT)   BEGIN
    INSERT INTO prendas (Nombre, Descripcion, Precio, Stock, id_categoria, id_talla, id_estilo)
    VALUES (nom, descripcion, precio, stock, catID, tallaID, estiloID);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarUsuario` (IN `userID` INT)   BEGIN
    DELETE FROM usuarios WHERE id_user = userID;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `CantidadEnCategoria` (`catID` INT) RETURNS INT(11)  BEGIN
    DECLARE cantidad INT;
    SELECT COUNT(*) INTO cantidad FROM prendas WHERE id_categoria = catID;
    RETURN cantidad;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `PrecioConDescuento` (`precioOriginal` DECIMAL(10,2), `descuento` INT) RETURNS DECIMAL(10,2)  BEGIN
    RETURN precioOriginal - (precioOriginal * descuento / 100);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `TotalGastadoPorUsuario` (`userID` INT) RETURNS DECIMAL(10,2)  BEGIN
    DECLARE totalGastado DECIMAL(10,2);
    SELECT SUM(PrecioTotal) INTO totalGastado
    FROM detallesdelpedido d
    JOIN pedidos p ON d.id_pedido = p.id_pedido
    WHERE p.id_user = userID;
    RETURN IFNULL(totalGastado, 0);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carritodecompras`
--

CREATE TABLE `carritodecompras` (
  `id_carrito` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `FechaCreacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carritodecompras`
--

INSERT INTO `carritodecompras` (`id_carrito`, `id_user`, `FechaCreacion`) VALUES
(1, 1, '2023-11-13 12:30:00'),
(2, 2, '2023-11-13 14:45:00'),
(3, 3, '2023-11-13 16:20:00'),
(4, 4, '2023-11-13 18:05:00'),
(5, 5, '2023-11-13 20:30:00'),
(6, 6, '2023-11-13 22:15:00'),
(7, 7, '2023-11-13 23:45:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `NombreCategoria` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `NombreCategoria`) VALUES
(1, 'Camisetas'),
(2, 'Camisas'),
(3, 'Pantalones'),
(4, 'Faldas'),
(5, 'Zapatos'),
(6, 'Vestidos'),
(7, 'Hoodies');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudad`
--

CREATE TABLE `ciudad` (
  `id_ciudad` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `id_departamento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ciudad`
--

INSERT INTO `ciudad` (`id_ciudad`, `nombre`, `id_departamento`) VALUES
(1, 'Medellín', 1),
(2, 'Cali', 3),
(3, 'Barranquilla', 4),
(4, 'Bogotá', 2),
(5, 'Bucaramanga', 5),
(6, 'Cartagena', 7),
(7, 'Manizales', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `codigopostal`
--

CREATE TABLE `codigopostal` (
  `id_cod_postal` int(11) NOT NULL,
  `codigo_postal` varchar(10) DEFAULT NULL,
  `id_ciudad` int(11) DEFAULT NULL,
  `id_departamento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `codigopostal`
--

INSERT INTO `codigopostal` (`id_cod_postal`, `codigo_postal`, `id_ciudad`, `id_departamento`) VALUES
(1, '050001', 1, 1),
(2, '760001', 2, 3),
(3, '080001', 4, 2),
(4, '200001', 5, 5),
(5, '680001', 6, 7),
(6, '110001', 7, 1),
(7, '170001', 3, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `id_departamento` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `departamento`
--

INSERT INTO `departamento` (`id_departamento`, `nombre`) VALUES
(1, 'Antioquia'),
(2, 'Bogotá D.C.'),
(3, 'Valle del Cauca'),
(4, 'Atlántico'),
(5, 'Santander'),
(6, 'Cundinamarca'),
(7, 'Bolívar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallesdelcarrito`
--

CREATE TABLE `detallesdelcarrito` (
  `id_detalle_carrito` int(11) NOT NULL,
  `id_carrito` int(11) DEFAULT NULL,
  `id_prenda` int(11) DEFAULT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `PrecioTotal` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detallesdelcarrito`
--

INSERT INTO `detallesdelcarrito` (`id_detalle_carrito`, `id_carrito`, `id_prenda`, `Cantidad`, `PrecioTotal`) VALUES
(1, 1, 1, 2, 50000.00),
(2, 2, 3, 1, 55000.00),
(3, 3, 5, 3, 360000.00),
(4, 4, 7, 2, 170000.00),
(5, 5, 2, 1, 45000.00),
(6, 6, 4, 4, 180000.00),
(7, 7, 6, 1, 120000.00),
(8, 1, 1, 11, 100000.00);

--
-- Disparadores `detallesdelcarrito`
--
DELIMITER $$
CREATE TRIGGER `ValidarStockAntesCarrito` BEFORE INSERT ON `detallesdelcarrito` FOR EACH ROW BEGIN
    DECLARE stockActual INT;
    SELECT Stock INTO stockActual FROM prendas WHERE id_prenda = NEW.id_prenda;
    IF stockActual < NEW.Cantidad THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallesdelpedido`
--

CREATE TABLE `detallesdelpedido` (
  `id_detalle_pedido` int(11) NOT NULL,
  `id_pedido` int(11) DEFAULT NULL,
  `id_prenda` int(11) DEFAULT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `PrecioTotal` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detallesdelpedido`
--

INSERT INTO `detallesdelpedido` (`id_detalle_pedido`, `id_pedido`, `id_prenda`, `Cantidad`, `PrecioTotal`) VALUES
(1, 1, 1, 2, 50000.00),
(2, 2, 3, 1, 55000.00),
(3, 3, 5, 3, 360000.00),
(4, 4, 7, 2, 170000.00),
(5, 5, 2, 1, 45000.00),
(6, 6, 4, 4, 180000.00),
(7, 7, 6, 1, 120000.00);

--
-- Disparadores `detallesdelpedido`
--
DELIMITER $$
CREATE TRIGGER `ActualizarStockDespuesPedido` AFTER INSERT ON `detallesdelpedido` FOR EACH ROW BEGIN
    UPDATE prendas SET Stock = Stock - NEW.Cantidad
    WHERE id_prenda = NEW.id_prenda;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estilos`
--

CREATE TABLE `estilos` (
  `id_estilo` int(11) NOT NULL,
  `estilo` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estilos`
--

INSERT INTO `estilos` (`id_estilo`, `estilo`) VALUES
(1, 'Femenino'),
(2, 'Masculino'),
(3, 'Unisex');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `DireccionEnvioID` int(11) DEFAULT NULL,
  `FechaPedido` datetime DEFAULT NULL,
  `EstadoPedido` enum('pendiente','enviado','entregado') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id_pedido`, `id_user`, `DireccionEnvioID`, `FechaPedido`, `EstadoPedido`) VALUES
(1, 1, 1, '2023-11-14 10:00:00', 'pendiente'),
(2, 2, 3, '2023-11-14 11:15:00', 'pendiente'),
(3, 3, 2, '2023-11-14 12:30:00', 'pendiente'),
(4, 4, 5, '2023-11-14 13:45:00', 'pendiente'),
(5, 5, 6, '2023-11-14 15:00:00', 'pendiente'),
(6, 6, 7, '2023-11-14 16:15:00', 'pendiente'),
(7, 7, 1, '2023-11-14 17:30:00', 'pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prendas`
--

CREATE TABLE `prendas` (
  `id_prenda` int(11) NOT NULL,
  `Nombre` varchar(255) DEFAULT NULL,
  `Descripcion` text DEFAULT NULL,
  `Precio` decimal(10,2) DEFAULT NULL,
  `Stock` int(11) DEFAULT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `id_talla` int(11) DEFAULT NULL,
  `id_estilo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `prendas`
--

INSERT INTO `prendas` (`id_prenda`, `Nombre`, `Descripcion`, `Precio`, `Stock`, `id_categoria`, `id_talla`, `id_estilo`) VALUES
(1, 'Camiseta básica', 'Camiseta de algodón negro', 25000.00, 80, 1, 1, 1),
(2, 'Camisa a rayas', 'Camisa de manga larga', 55000.00, 50, 2, 2, 2),
(3, 'Pantalón casual', 'Pantalón de mezclilla azul', 75000.00, 30, 3, 3, 3),
(4, 'Falda floral', 'Falda corta estampada', 45000.00, 40, 4, 1, 1),
(5, 'Zapatos deportivos', 'Zapatos para correr', 120000.00, 20, 5, 4, 2),
(6, 'Vestido elegante', 'Vestido largo de fiesta', 120000.00, 15, 6, 3, 3),
(7, 'Hoodie con capucha', 'Hoodie unisex gris', 85000.00, 25, 7, 2, 1),
(8, 'Falda de rayas', 'Falda de drill', 30000.00, 23, 4, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_actividad`
--

CREATE TABLE `registro_actividad` (
  `id_registro` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `actividad` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registro_actividad`
--

INSERT INTO `registro_actividad` (`id_registro`, `id_user`, `fecha`, `actividad`) VALUES
(1, 1, '2023-11-13 22:58:25', 'Login');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tallas`
--

CREATE TABLE `tallas` (
  `id_talla` int(11) NOT NULL,
  `talla` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tallas`
--

INSERT INTO `tallas` (`id_talla`, `talla`) VALUES
(1, 'S'),
(2, 'M'),
(3, 'L'),
(4, 'XL');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_user` int(11) NOT NULL,
  `Nombre` varchar(255) DEFAULT NULL,
  `Apellido` varchar(255) DEFAULT NULL,
  `CorreoElectronico` varchar(255) DEFAULT NULL,
  `Contraseña` varchar(255) DEFAULT NULL,
  `TipoUsuario` enum('Cliente','Administrador') DEFAULT NULL,
  `Direccion` text DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `cod_postal` int(11) DEFAULT NULL,
  `id_ciudad` int(11) DEFAULT NULL,
  `id_departamento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_user`, `Nombre`, `Apellido`, `CorreoElectronico`, `Contraseña`, `TipoUsuario`, `Direccion`, `Telefono`, `cod_postal`, `id_ciudad`, `id_departamento`) VALUES
(1, 'Juan', 'Pérez', 'jsi123@gmail.com', 'password', 'Cliente', 'Carrera 45 #23-56', '3101234567', 1, 1, 1),
(2, 'María', 'Gómez', 'maria.gomez@hotmail.com', 'secreto', 'Administrador', 'Calle 70 #12-34', '3159876543', 2, 3, 3),
(3, 'Carlos', 'Rodríguez', 'carlos.rodriguez@gmail.com', 'clave', 'Cliente', 'Avenida 80 #45-67', '3201112233', 4, 2, 2),
(4, 'Laura', 'Martínez', 'laura.martinez@yahoo.com', 'contrasena', 'Cliente', 'Calle 100 #56-78', '3184445556', 5, 5, 5),
(5, 'Andrés', 'López', 'andres.lopez@gmail.com', 'pass123', 'Cliente', 'Carrera 32 #45-67', '3009876543', 6, 6, 7),
(6, 'Ana', 'Sánchez', 'ana.sanchez@hotmail.com', '1234', 'Cliente', 'Calle 10 #11-12', '3171234567', 7, 7, 1),
(7, 'Oscar', 'Ramírez', 'oscar.ramirez@gmail.com', 'clave123', 'Cliente', 'Carrera 15 #19-20', '3145556667', 3, 4, 4);

--
-- Disparadores `usuarios`
--
DELIMITER $$
CREATE TRIGGER `RegistrarLoginUsuario` AFTER UPDATE ON `usuarios` FOR EACH ROW BEGIN
    INSERT INTO registro_actividad (id_user, fecha, actividad)
    VALUES (NEW.id_user, NOW(), 'Login');
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carritodecompras`
--
ALTER TABLE `carritodecompras`
  ADD PRIMARY KEY (`id_carrito`),
  ADD KEY `id_user` (`id_user`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  ADD PRIMARY KEY (`id_ciudad`),
  ADD KEY `id_departamento` (`id_departamento`);

--
-- Indices de la tabla `codigopostal`
--
ALTER TABLE `codigopostal`
  ADD PRIMARY KEY (`id_cod_postal`),
  ADD KEY `id_ciudad` (`id_ciudad`),
  ADD KEY `id_departamento` (`id_departamento`);

--
-- Indices de la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`id_departamento`);

--
-- Indices de la tabla `detallesdelcarrito`
--
ALTER TABLE `detallesdelcarrito`
  ADD PRIMARY KEY (`id_detalle_carrito`),
  ADD KEY `id_carrito` (`id_carrito`),
  ADD KEY `id_prenda` (`id_prenda`);

--
-- Indices de la tabla `detallesdelpedido`
--
ALTER TABLE `detallesdelpedido`
  ADD PRIMARY KEY (`id_detalle_pedido`),
  ADD KEY `id_pedido` (`id_pedido`),
  ADD KEY `id_prenda` (`id_prenda`);

--
-- Indices de la tabla `estilos`
--
ALTER TABLE `estilos`
  ADD PRIMARY KEY (`id_estilo`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `id_user` (`id_user`);

--
-- Indices de la tabla `prendas`
--
ALTER TABLE `prendas`
  ADD PRIMARY KEY (`id_prenda`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_talla` (`id_talla`),
  ADD KEY `id_estilo` (`id_estilo`);

--
-- Indices de la tabla `registro_actividad`
--
ALTER TABLE `registro_actividad`
  ADD PRIMARY KEY (`id_registro`),
  ADD KEY `id_user` (`id_user`);

--
-- Indices de la tabla `tallas`
--
ALTER TABLE `tallas`
  ADD PRIMARY KEY (`id_talla`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `CorreoElectronico` (`CorreoElectronico`),
  ADD KEY `cod_postal` (`cod_postal`),
  ADD KEY `id_ciudad` (`id_ciudad`),
  ADD KEY `id_departamento` (`id_departamento`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carritodecompras`
--
ALTER TABLE `carritodecompras`
  MODIFY `id_carrito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  MODIFY `id_ciudad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `codigopostal`
--
ALTER TABLE `codigopostal`
  MODIFY `id_cod_postal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `departamento`
--
ALTER TABLE `departamento`
  MODIFY `id_departamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detallesdelcarrito`
--
ALTER TABLE `detallesdelcarrito`
  MODIFY `id_detalle_carrito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `detallesdelpedido`
--
ALTER TABLE `detallesdelpedido`
  MODIFY `id_detalle_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `estilos`
--
ALTER TABLE `estilos`
  MODIFY `id_estilo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `prendas`
--
ALTER TABLE `prendas`
  MODIFY `id_prenda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `registro_actividad`
--
ALTER TABLE `registro_actividad`
  MODIFY `id_registro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tallas`
--
ALTER TABLE `tallas`
  MODIFY `id_talla` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carritodecompras`
--
ALTER TABLE `carritodecompras`
  ADD CONSTRAINT `carritodecompras_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `usuarios` (`id_user`);

--
-- Filtros para la tabla `ciudad`
--
ALTER TABLE `ciudad`
  ADD CONSTRAINT `ciudad_ibfk_1` FOREIGN KEY (`id_departamento`) REFERENCES `departamento` (`id_departamento`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `codigopostal`
--
ALTER TABLE `codigopostal`
  ADD CONSTRAINT `codigopostal_ibfk_1` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`id_ciudad`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `codigopostal_ibfk_2` FOREIGN KEY (`id_departamento`) REFERENCES `departamento` (`id_departamento`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detallesdelcarrito`
--
ALTER TABLE `detallesdelcarrito`
  ADD CONSTRAINT `detallesdelcarrito_ibfk_1` FOREIGN KEY (`id_carrito`) REFERENCES `carritodecompras` (`id_carrito`),
  ADD CONSTRAINT `detallesdelcarrito_ibfk_2` FOREIGN KEY (`id_prenda`) REFERENCES `prendas` (`id_prenda`);

--
-- Filtros para la tabla `detallesdelpedido`
--
ALTER TABLE `detallesdelpedido`
  ADD CONSTRAINT `detallesdelpedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`),
  ADD CONSTRAINT `detallesdelpedido_ibfk_2` FOREIGN KEY (`id_prenda`) REFERENCES `prendas` (`id_prenda`);

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `usuarios` (`id_user`);

--
-- Filtros para la tabla `prendas`
--
ALTER TABLE `prendas`
  ADD CONSTRAINT `prendas_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`),
  ADD CONSTRAINT `prendas_ibfk_2` FOREIGN KEY (`id_talla`) REFERENCES `tallas` (`id_talla`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `prendas_ibfk_3` FOREIGN KEY (`id_estilo`) REFERENCES `estilos` (`id_estilo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `registro_actividad`
--
ALTER TABLE `registro_actividad`
  ADD CONSTRAINT `registro_actividad_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `usuarios` (`id_user`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`cod_postal`) REFERENCES `codigopostal` (`id_cod_postal`),
  ADD CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`id_ciudad`),
  ADD CONSTRAINT `usuarios_ibfk_3` FOREIGN KEY (`id_departamento`) REFERENCES `departamento` (`id_departamento`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
