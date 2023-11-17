-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-11-2023 a las 21:32:54
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.1.12

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
    UPDATE prenda SET Stock = nuevoStock WHERE id_prenda = prendaID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarProducto` (IN `nom` VARCHAR(255), IN `descripcion` TEXT, IN `precio` DECIMAL(10,2), IN `stock` INT, IN `catID` INT, IN `tallaID` INT, IN `estiloID` INT)   BEGIN
    INSERT INTO prenda (Nombre, Descripcion, Precio, Stock, id_categoria, id_talla, id_estilo)
    VALUES (nom, descripcion, precio, stock, catID, tallaID, estiloID);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarUsuario` (IN `userID` INT)   BEGIN
    DELETE FROM usuario WHERE id_user = userID;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `CantidadEnCategoria` (`catID` INT) RETURNS INT(11)  BEGIN
    DECLARE cantidad INT;
    SELECT COUNT(*) INTO cantidad FROM prenda WHERE id_categoria = catID;
    RETURN cantidad;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `PrecioConDescuento` (`precioOriginal` DECIMAL(10,2), `descuento` INT) RETURNS DECIMAL(10,2)  BEGIN
    RETURN precioOriginal - (precioOriginal * descuento / 100);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `TotalGastadoPorUsuario` (`userID` INT) RETURNS DECIMAL(10,2)  BEGIN
    DECLARE totalGastado DECIMAL(10,2);
    SELECT SUM(PrecioTotal) INTO totalGastado
    FROM detallepedido d
    JOIN pedido p ON d.id_pedido = p.id_pedido
    WHERE p.id_user = userID;
    RETURN IFNULL(totalGastado, 0);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `id_carrito` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_prenda` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carrito`
--

INSERT INTO `carrito` (`id_carrito`, `id_user`, `id_prenda`, `cantidad`) VALUES
(1, 1, 1, 2),
(2, 2, 3, 1),
(3, 3, 5, 2),
(4, 4, 7, 1),
(5, 5, 6, 3),
(6, 6, 2, 2),
(7, 7, 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `NombreCategoria` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `NombreCategoria`) VALUES
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
(2, 'Bogotá', 2),
(3, 'Cali', 3),
(4, 'Barranquilla', 4),
(5, 'Bucaramanga', 5),
(6, 'Cartagena', 6),
(7, 'Tunja', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `codigo_postal`
--

CREATE TABLE `codigo_postal` (
  `id_cod_postal` int(11) NOT NULL,
  `codigo_postal` varchar(6) DEFAULT NULL,
  `id_ciudad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `codigo_postal`
--

INSERT INTO `codigo_postal` (`id_cod_postal`, `codigo_postal`, `id_ciudad`) VALUES
(1, '050001', 1),
(2, '110111', 2),
(3, '760001', 3),
(4, '080001', 4),
(5, '680001', 5),
(6, '130001', 6),
(7, '150001', 7);

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
(2, 'Cundinamarca'),
(3, 'Valle del Cauca'),
(4, 'Atlántico'),
(5, 'Santander'),
(6, 'Bolívar'),
(7, 'Boyacá');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallepedido`
--

CREATE TABLE `detallepedido` (
  `id_detalle_pedido` int(11) NOT NULL,
  `id_pedido` int(11) DEFAULT NULL,
  `id_prenda` int(11) DEFAULT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `PrecioTotal` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detallepedido`
--

INSERT INTO `detallepedido` (`id_detalle_pedido`, `id_pedido`, `id_prenda`, `Cantidad`, `PrecioTotal`) VALUES
(1, 1, 1, 2, '40000.00'),
(2, 2, 3, 1, '80000.00'),
(3, 3, 5, 2, '240000.00'),
(4, 4, 7, 1, '70000.00'),
(5, 5, 6, 3, '450000.00'),
(6, 6, 2, 2, '100000.00'),
(7, 7, 4, 1, '40000.00');

--
-- Disparadores `detallepedido`
--
DELIMITER $$
CREATE TRIGGER `ActualizarStockDespuesPedido` AFTER INSERT ON `detallepedido` FOR EACH ROW BEGIN
    UPDATE prenda SET Stock = Stock - NEW.Cantidad
    WHERE id_prenda = NEW.id_prenda;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ValidarStockAntesCarrito` BEFORE INSERT ON `detallepedido` FOR EACH ROW BEGIN
    DECLARE stockActual INT;
    SELECT Stock INTO stockActual FROM prenda WHERE id_prenda = NEW.id_prenda;
    IF stockActual < NEW.Cantidad THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direccion`
--

CREATE TABLE `direccion` (
  `id_direccion` int(11) NOT NULL,
  `id_tipo_calle` int(11) DEFAULT NULL,
  `calle` varchar(255) DEFAULT NULL,
  `numero` varchar(255) DEFAULT NULL,
  `numero2` varchar(255) DEFAULT NULL,
  `barrio` varchar(255) DEFAULT NULL,
  `id_codigopostal` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `direccion`
--

INSERT INTO `direccion` (`id_direccion`, `id_tipo_calle`, `calle`, `numero`, `numero2`, `barrio`, `id_codigopostal`) VALUES
(1, 1, '22B', '50', '30', 'El Poblado', 1),
(2, 2, '4 Sur', '80', '15', 'Chapinero', 2),
(3, 3, '48', '23', '58', 'Granada', 3),
(4, 1, '70', '100', '40', 'El Prado', 4),
(5, 2, '33', '76', '12', 'Cabecera', 5),
(6, 3, 'San Martín', '20', '22', 'Getsemaní', 6),
(7, 1, '15', '33', '55', 'Maldonado', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estilo`
--

CREATE TABLE `estilo` (
  `id_estilo` int(11) NOT NULL,
  `estilo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estilo`
--

INSERT INTO `estilo` (`id_estilo`, `estilo`) VALUES
(1, 'Femenino'),
(2, 'Masculino'),
(3, 'Unisex');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `id_pedido` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_direccion` int(11) DEFAULT NULL,
  `FechaPedido` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `EstadoPedido` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`id_pedido`, `id_user`, `id_direccion`, `FechaPedido`, `EstadoPedido`) VALUES
(1, 1, 1, '2023-11-17 05:37:14', 'Entregado'),
(2, 2, 2, '2023-11-17 05:37:14', 'En proceso'),
(3, 3, 3, '2023-11-17 05:37:14', 'En proceso'),
(4, 4, 4, '2023-11-17 05:37:14', 'Cancelado'),
(5, 5, 5, '2023-11-17 05:37:14', 'Entregado'),
(6, 6, 6, '2023-11-17 05:37:14', 'En proceso'),
(7, 7, 7, '2023-11-17 05:37:14', 'Entregado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prenda`
--

CREATE TABLE `prenda` (
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
-- Volcado de datos para la tabla `prenda`
--

INSERT INTO `prenda` (`id_prenda`, `Nombre`, `Descripcion`, `Precio`, `Stock`, `id_categoria`, `id_talla`, `id_estilo`) VALUES
(1, 'Camiseta Básica', 'Camiseta algodón color blanco', '20000.00', 50, 1, 1, 3),
(2, 'Camisa Formal', 'Camisa manga larga color azul', '50000.00', 30, 2, 2, 2),
(3, 'Jeans Clásicos', 'Jeans azules corte recto', '80000.00', 40, 3, 3, 3),
(4, 'Falda Plisada', 'Falda corta color negro', '40000.00', 25, 4, 4, 1),
(5, 'Zapatos Deportivos', 'Zapatos para correr color gris', '120000.00', 20, 5, 1, 3),
(6, 'Vestido de Noche', 'Vestido largo elegante color rojo', '150000.00', 15, 6, 2, 1),
(7, 'Hoodie Clásico', 'Hoodie algodón color negro', '70000.00', 35, 7, 3, 3),
(8, 'Camiseta SNK', 'Camiseta con estampado', '30000.00', 50, 1, 1, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_actividad`
--

CREATE TABLE `registro_actividad` (
  `id_registro` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `actividad` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registro_actividad`
--

INSERT INTO `registro_actividad` (`id_registro`, `id_user`, `fecha`, `actividad`) VALUES
(1, 1, '2023-11-17 05:52:41', 'Usuario actualizado. Cambios en: correo electrónico, ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `talla`
--

CREATE TABLE `talla` (
  `id_talla` int(11) NOT NULL,
  `talla` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `talla`
--

INSERT INTO `talla` (`id_talla`, `talla`) VALUES
(1, 'S'),
(2, 'M'),
(3, 'L'),
(4, 'XL');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_calle`
--

CREATE TABLE `tipo_calle` (
  `id_tipo_calle` int(11) NOT NULL,
  `tipo_calle` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_calle`
--

INSERT INTO `tipo_calle` (`id_tipo_calle`, `tipo_calle`) VALUES
(1, 'Calle'),
(2, 'Carrera'),
(3, 'Avenida'),
(4, 'Transversal'),
(5, 'Diagonal'),
(6, 'Circular'),
(7, 'Pasaje');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_user` int(11) NOT NULL,
  `Primer_nombre` varchar(255) DEFAULT NULL,
  `Segundo_nombre` varchar(255) DEFAULT NULL,
  `Primer_Apellido` varchar(255) DEFAULT NULL,
  `Segundo_apellido` varchar(255) DEFAULT NULL,
  `Correo_Electronico` varchar(255) DEFAULT NULL,
  `Contraseña` varchar(255) DEFAULT NULL,
  `TipoUsuario` enum('Cliente','Administrador') DEFAULT NULL,
  `Telefono` varchar(10) DEFAULT NULL,
  `id_direccion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_user`, `Primer_nombre`, `Segundo_nombre`, `Primer_Apellido`, `Segundo_apellido`, `Correo_Electronico`, `Contraseña`, `TipoUsuario`, `Telefono`, `id_direccion`) VALUES
(1, 'Juan', 'Carlos', 'González', 'López', 'jsi123@gmail.com', 'pass123', 'Cliente', '3201234567', 1),
(2, 'Laura', 'Sofía', 'Martínez', 'Díaz', 'laura.martinez@example.com', 'pass456', 'Cliente', '3123456789', 2),
(3, 'Carlos', 'Andrés', 'Rodríguez', 'Gómez', 'carlos.rodriguez@example.com', 'pass789', 'Administrador', '3001234567', 3),
(4, 'María', 'Paula', 'Hernández', 'Ruiz', 'maria.hernandez@example.com', 'pass101', 'Cliente', '3156789012', 4),
(5, 'Sergio', 'Luis', 'Pérez', 'Jiménez', 'sergio.perez@example.com', 'pass102', 'Cliente', '3183456789', 5),
(6, 'Catalina', 'Isabel', 'Gómez', 'Fernández', 'catalina.gomez@example.com', 'pass103', 'Cliente', '3161234567', 6),
(7, 'Esteban', 'José', 'Moreno', 'Cardona', 'esteban.moreno@example.com', 'pass104', 'Cliente', '3172345678', 7);

--
-- Disparadores `usuario`
--
DELIMITER $$
CREATE TRIGGER `RegistrarCambiosUsuario` AFTER UPDATE ON `usuario` FOR EACH ROW BEGIN
    INSERT INTO registro_actividad (id_user, fecha, actividad)
    VALUES (
        NEW.id_user,
        NOW(),
        CONCAT('Usuario actualizado. Cambios en: ', 
               IF(OLD.Primer_nombre != NEW.Primer_nombre, 'nombre, ', ''), 
               IF(OLD.Primer_Apellido != NEW.Primer_Apellido, 'apellido, ', ''),
               IF(OLD.Correo_Electronico != NEW.Correo_Electronico, 'correo electrónico, ', ''),
               IF(OLD.Contraseña != NEW.Contraseña, 'contraseña, ', ''),
               IF(OLD.TipoUsuario != NEW.TipoUsuario, 'tipo de usuario, ', ''),
               IF(OLD.Telefono != NEW.Telefono, 'teléfono, ', ''),
               IF(OLD.id_direccion != NEW.id_direccion, 'dirección', ''))
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wishlist`
--

CREATE TABLE `wishlist` (
  `id_wishlist` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_prenda` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `wishlist`
--

INSERT INTO `wishlist` (`id_wishlist`, `id_user`, `id_prenda`) VALUES
(1, 1, 6),
(2, 2, 7),
(3, 3, 5),
(4, 4, 1),
(5, 5, 3),
(6, 6, 2),
(7, 7, 4);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id_carrito`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_prenda` (`id_prenda`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  ADD PRIMARY KEY (`id_ciudad`),
  ADD KEY `id_departamento` (`id_departamento`);

--
-- Indices de la tabla `codigo_postal`
--
ALTER TABLE `codigo_postal`
  ADD PRIMARY KEY (`id_cod_postal`),
  ADD KEY `id_ciudad` (`id_ciudad`);

--
-- Indices de la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`id_departamento`);

--
-- Indices de la tabla `detallepedido`
--
ALTER TABLE `detallepedido`
  ADD PRIMARY KEY (`id_detalle_pedido`),
  ADD KEY `id_pedido` (`id_pedido`),
  ADD KEY `id_prenda` (`id_prenda`);

--
-- Indices de la tabla `direccion`
--
ALTER TABLE `direccion`
  ADD PRIMARY KEY (`id_direccion`),
  ADD KEY `id_tipo_calle` (`id_tipo_calle`),
  ADD KEY `id_codigopostal` (`id_codigopostal`);

--
-- Indices de la tabla `estilo`
--
ALTER TABLE `estilo`
  ADD PRIMARY KEY (`id_estilo`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_direccion` (`id_direccion`);

--
-- Indices de la tabla `prenda`
--
ALTER TABLE `prenda`
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
-- Indices de la tabla `talla`
--
ALTER TABLE `talla`
  ADD PRIMARY KEY (`id_talla`);

--
-- Indices de la tabla `tipo_calle`
--
ALTER TABLE `tipo_calle`
  ADD PRIMARY KEY (`id_tipo_calle`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `id_direccion` (`id_direccion`);

--
-- Indices de la tabla `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id_wishlist`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_prenda` (`id_prenda`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id_carrito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  MODIFY `id_ciudad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `codigo_postal`
--
ALTER TABLE `codigo_postal`
  MODIFY `id_cod_postal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `departamento`
--
ALTER TABLE `departamento`
  MODIFY `id_departamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detallepedido`
--
ALTER TABLE `detallepedido`
  MODIFY `id_detalle_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `direccion`
--
ALTER TABLE `direccion`
  MODIFY `id_direccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `estilo`
--
ALTER TABLE `estilo`
  MODIFY `id_estilo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `prenda`
--
ALTER TABLE `prenda`
  MODIFY `id_prenda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `registro_actividad`
--
ALTER TABLE `registro_actividad`
  MODIFY `id_registro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `talla`
--
ALTER TABLE `talla`
  MODIFY `id_talla` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipo_calle`
--
ALTER TABLE `tipo_calle`
  MODIFY `id_tipo_calle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id_wishlist` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `usuario` (`id_user`),
  ADD CONSTRAINT `carrito_ibfk_2` FOREIGN KEY (`id_prenda`) REFERENCES `prenda` (`id_prenda`);

--
-- Filtros para la tabla `ciudad`
--
ALTER TABLE `ciudad`
  ADD CONSTRAINT `ciudad_ibfk_1` FOREIGN KEY (`id_departamento`) REFERENCES `departamento` (`id_departamento`);

--
-- Filtros para la tabla `codigo_postal`
--
ALTER TABLE `codigo_postal`
  ADD CONSTRAINT `codigo_postal_ibfk_1` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`id_ciudad`);

--
-- Filtros para la tabla `detallepedido`
--
ALTER TABLE `detallepedido`
  ADD CONSTRAINT `detallepedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`),
  ADD CONSTRAINT `detallepedido_ibfk_2` FOREIGN KEY (`id_prenda`) REFERENCES `prenda` (`id_prenda`);

--
-- Filtros para la tabla `direccion`
--
ALTER TABLE `direccion`
  ADD CONSTRAINT `direccion_ibfk_1` FOREIGN KEY (`id_tipo_calle`) REFERENCES `tipo_calle` (`id_tipo_calle`),
  ADD CONSTRAINT `direccion_ibfk_2` FOREIGN KEY (`id_codigopostal`) REFERENCES `codigo_postal` (`id_cod_postal`);

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `usuario` (`id_user`),
  ADD CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`id_direccion`) REFERENCES `direccion` (`id_direccion`);

--
-- Filtros para la tabla `prenda`
--
ALTER TABLE `prenda`
  ADD CONSTRAINT `prenda_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`),
  ADD CONSTRAINT `prenda_ibfk_2` FOREIGN KEY (`id_talla`) REFERENCES `talla` (`id_talla`),
  ADD CONSTRAINT `prenda_ibfk_3` FOREIGN KEY (`id_estilo`) REFERENCES `estilo` (`id_estilo`);

--
-- Filtros para la tabla `registro_actividad`
--
ALTER TABLE `registro_actividad`
  ADD CONSTRAINT `registro_actividad_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `usuario` (`id_user`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_direccion`) REFERENCES `direccion` (`id_direccion`);

--
-- Filtros para la tabla `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `usuario` (`id_user`),
  ADD CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`id_prenda`) REFERENCES `prenda` (`id_prenda`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
