-- Subconsultas

-- 1. Total de Ventas por Categoría:

SELECT c.NombreCategoria, SUM(d.PrecioTotal) AS TotalVentas
FROM categorias c
JOIN prendas p ON c.id_categoria = p.id_categoria
JOIN detallesdelpedido d ON p.id_prenda = d.id_prenda
GROUP BY c.NombreCategoria;

-- 2. Productos Más Vendidos:

SELECT p.Nombre, COUNT(d.id_prenda) AS VecesVendido
FROM prendas p
JOIN detallesdelpedido d ON p.id_prenda = d.id_prenda
GROUP BY p.Nombre
ORDER BY VecesVendido DESC
LIMIT 5;

-- 3. Clientes con Más Compras:

SELECT u.Nombre, u.Apellido, COUNT(p.id_pedido) AS NumeroDePedidos
FROM usuarios u
JOIN pedidos p ON u.id_user = p.id_user
GROUP BY u.id_user
ORDER BY NumeroDePedidos DESC
LIMIT 5;


-- Procedimientos

--Agregar Nuevo Producto:

DELIMITER //
CREATE PROCEDURE AgregarProducto(
    IN nom VARCHAR(255),
    IN descripcion TEXT,
    IN precio DECIMAL(10,2),
    IN stock INT,
    IN catID INT,
    IN tallaID INT,
    IN estiloID INT
)
BEGIN
    INSERT INTO prendas (Nombre, Descripcion, Precio, Stock, id_categoria, id_talla, id_estilo)
    VALUES (nom, descripcion, precio, stock, catID, tallaID, estiloID);
END //
DELIMITER ;



CALL AgregarProducto('Nueva Camiseta', 'Descripción de la camiseta', 30000, 50, 1, 1, 3);


-- 2. Actualizar Stock:

DELIMITER //
CREATE PROCEDURE ActualizarStock(
    IN prendaID INT,
    IN nuevoStock INT
)
BEGIN
    UPDATE prendas SET Stock = nuevoStock WHERE id_prenda = prendaID;
END //
DELIMITER ;


CALL ActualizarStock(1, 120);


-- 3.Eliminar Usuario:

DELIMITER //
CREATE PROCEDURE EliminarUsuario(IN userID INT)
BEGIN
    DELETE FROM usuarios WHERE id_user = userID;
END //
DELIMITER ;


CALL EliminarUsuario(7);


-- Disparadores (Triggers)

-- 1. Actualizar Stock al Realizar Pedido:

DELIMITER //
CREATE TRIGGER ActualizarStockDespuesPedido
AFTER INSERT ON detallesdelpedido
FOR EACH ROW
BEGIN
    UPDATE prendas SET Stock = Stock - NEW.Cantidad
    WHERE id_prenda = NEW.id_prenda;
END //
DELIMITER ;

-- verificamos el stock actual

SELECT Stock FROM prendas WHERE id_prenda = 1;

-- insertamos un nuevo detalle de pedido (esto activará el disparador):

INSERT INTO detallesdelpedido (id_pedido, id_prenda, Cantidad, PrecioTotal) VALUES (1, 1, 2, 50000.00);

-- verificamos el stock actual

SELECT Stock FROM prendas WHERE id_prenda = 1;



-- 2. Registro de Actividad de Usuarios:

DELIMITER //
CREATE TRIGGER RegistrarLoginUsuario
AFTER UPDATE ON usuarios
FOR EACH ROW
BEGIN
    INSERT INTO registro_actividad (id_user, fecha, actividad)
    VALUES (NEW.id_user, NOW(), 'Login');
END //
DELIMITER ;


-- actualizamos un registro en la tabla usuarios (esto activará el disparador):

UPDATE usuarios SET CorreoElectronico = 'jsi123@gmail.com' WHERE id_user = 1;


-- verifica el registro de actividad:

SELECT * FROM registro_actividad;


-- 3. Validar Stock Antes de Agregar al Carrito:

DELIMITER //
CREATE TRIGGER ValidarStockAntesCarrito
BEFORE INSERT ON detallesdelcarrito
FOR EACH ROW
BEGIN
    DECLARE stockActual INT;
    SELECT Stock INTO stockActual FROM prendas WHERE id_prenda = NEW.id_prenda;
    IF stockActual < NEW.Cantidad THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente';
    END IF;
END //
DELIMITER ;

-- Primero, verificamos el stock actual de la prenda:

SELECT Stock FROM prendas WHERE id_prenda = 1;

--Luego, intenta agregamos un detalle al carrito que exceda el stock (esto debería activar el disparador y prevenir la inserción):

INSERT INTO detallesdelcarrito (id_carrito, id_prenda, Cantidad, PrecioTotal) VALUES (1, 1, 11000, 100000.00);


-- Funciones

-- 1. Calcular Precio con Descuento:

DELIMITER //
CREATE FUNCTION PrecioConDescuento(precioOriginal DECIMAL(10,2), descuento INT)
RETURNS DECIMAL(10,2)
BEGIN
    RETURN precioOriginal - (precioOriginal * descuento / 100);
END //
DELIMITER ;


SELECT PrecioConDescuento(50000, 10);


-- 2.Cantidad de Productos en Categoría:

DELIMITER //
CREATE FUNCTION CantidadEnCategoria(catID INT)
RETURNS INT
BEGIN
    DECLARE cantidad INT;
    SELECT COUNT(*) INTO cantidad FROM prendas WHERE id_categoria = catID;
    RETURN cantidad;
END //
DELIMITER ;


SELECT CantidadEnCategoria(1);


-- 3. Calcular Total Gastado por Usuario

DELIMITER //
CREATE FUNCTION TotalGastadoPorUsuario(userID INT)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE totalGastado DECIMAL(10,2);
    SELECT SUM(PrecioTotal) INTO totalGastado
    FROM detallesdelpedido d
    JOIN pedidos p ON d.id_pedido = p.id_pedido
    WHERE p.id_user = userID;
    RETURN IFNULL(totalGastado, 0);
END //
DELIMITER ;


SELECT TotalGastadoPorUsuario(1);





