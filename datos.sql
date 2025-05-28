-- Insertar en Producto
INSERT INTO Producto (id, nombre, precio, categoria, disponible, elaborado) VALUES
(1, 'Pizza Margarita', '25000', 'pizza', 'si', 'si'),
(2, 'Panzarotti Napolitano', '18000', 'panzarotti', 'si', 'si'),
(3, 'Coca Cola 500ml', '5000', 'bebidas', 'si', 'no'),
(4, 'Helado Vainilla', '7000', 'postres', 'si', 'no');

-- Insertar en Ingredientes
INSERT INTO Ingredientes (id, nombre, cantidad) VALUES
(1, 'Queso Mozzarella', '200g'),
(2, 'Tomate', '150g'),
(3, 'Masa de Pizza', '300g'),
(4, 'Salsa de Tomate', '100g');

-- Insertar en Ingredientes_has_Producto
INSERT INTO Ingredientes_has_Producto (Ingredientes_id, Producto_id, id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(1, 2, 5),
(4, 2, 6);

-- Insertar en Combo
INSERT INTO Combo (id, nombre, descripcion, precio) VALUES
(1, 'Combo Individual', 'Pizza Margarita + Bebida', 29000),
(2, 'Combo Doble', '2 Panzarottis + 2 Bebidas', 46000);

-- Insertar en CombosProductos
INSERT INTO CombosProductos (idCombosProductos, cantidad, Combo_id, Producto_id) VALUES
(1, 1, 1, 1),
(2, 1, 1, 3),
(3, 2, 2, 2),
(4, 2, 2, 3);

-- Insertar en Cliente
INSERT INTO Cliente (id, nombre, telefono) VALUES
(1, 'Juan Pérez', '3101234567'),
(2, 'Laura Gómez', '3119876543');

-- Insertar en Pedido
INSERT INTO Pedido (id, fecha, metodoPago, modalidadPedido, Cliente_id) VALUES
(1, '2024-05-01 13:00:00', 'efectivo', 'mesa', 1),
(2, '2024-05-02 20:30:00', 'tarjeta', 'domicilio', 2);

-- Insertar en Adicionales
INSERT INTO Adicionales (id, nombre, precio) VALUES
(1, 'Queso extra', 2000),
(2, 'Tocineta', 3000);

-- Insertar en AdicionalesPedido
INSERT INTO AdicionalesPedido (id, cantidad, Adicionales_id1, Pedido_id) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2);

-- Insertar en ProductoPedido
INSERT INTO ProductoPedido (Producto_id, Pedido_id, cantidad, id) VALUES
(1, 1, 1, 1),
(3, 1, 1, 2),
(2, 2, 2, 3);

-- Insertar en ComboPedidos
INSERT INTO ComboPedidos (id, cantidad, Combo_id, Pedido_id) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2);
