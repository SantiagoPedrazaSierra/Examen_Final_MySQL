-- Inserciones de adiciones
INSERT INTO Adiciones (nombre) VALUES
("Queso"),
("Carne"),
("Tocino"),
("Maiz"),
("Chicharron");

-- Inserciones de porciones de adiciones 
INSERT INTO Adiciones (porciones) VALUES
("2"),
("3"),
("1"),
("2"),
("1");

-- Inserciones de productos
INSERT INTO Productos (nombre) VALUES
("Pizza Hawaiana"),
("Pizza Peperoni"),
("Pizza Mixta"),
("Panzarotti Sencillo"),
("Gaseosa");

-- Inserciones de ingredientes de los productos
INSERT INTO Productos (ingredientes) VALUES
("piña,queso,jamon."),
("queso,peperoni."),
("queso,carne,maiz,pollo."),
("jamon,queso,champiñones."),
("Gaseosa");

-- Inserciones de ingredientes de los productos
INSERT INTO Productos (precio) VALUES
("10000"),
("5000"),
("6000"),
("7000"),
("1000");

-- Inserciones de descripcion de los combos
INSERT INTO Combos (descripcion) VALUES
("Pizza Hawaiana + Gaseosa"),
("Pizza Peperoni + Gaseosa"),
("Pizza Mixta + Gaseosa"),
("Panzarotti Sencillo + Gaseosa"),
("Pizza Mista + Pizza Peperoni");

-- Inserciones de precio de los combos
INSERT INTO Productos (precio) VALUES
("10500"),
("5500"),
("6500"),
("7500"),
("12000");

-- Inserciones de pedidos
INSERT INTO Pedidos (pedido) VALUES
("Pizza Hawaiana + Gaseosa"),
("Pizza Peperoni + Gaseosa"),
("Pizza Mixta + Gaseosa"),
("Panzarotti Sencillo + Gaseosa"),
("Pizza Mista + Pizza Peperoni");

-- Inserciones de precio de los pedidos vendidos
INSERT INTO Pedidos_vendidos (valor) VALUES
("10500"),
("5500"),
("6500"),
("7500"),
("12000");

-- Inserciones de ganancias en ventas 
INSERT INTO Ventas (ganancias) VALUES
("10500"),
("5500"),
("6500"),
("7500"),
("12000");

