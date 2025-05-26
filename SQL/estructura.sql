CREATE DATABASE IF NOT EXISTS Pizzeria;

USE Pizzeria;

-- Tabla Adiciones
CREATE TABLE Adiciones(
	id INT auto_increment PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL,
    porciones INT
);

-- Tabla Productos
CREATE TABLE Productos(
	id INT auto_increment PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
    ingredientes TEXT NOT NULL,
    precio DECIMAL(10,2) NOT NULL
    
);

-- Tabla Combos
CREATE TABLE Combos(
	id INT auto_increment PRIMARY KEY,
	descripcion TEXT NOT NULL,
	precio INT NOT NULL
);

-- Tabla Productos Combos
CREATE TABLE Productos_combos(
	id INT auto_increment PRIMARY KEY,
    id_producto INT NOT NULL,
    id_combo INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES Productos(id),
    FOREIGN KEY (id_combo) REFERENCES Combos(id)
);

-- Tabla Menu 
CREATE TABLE Menu(
	id INT auto_increment PRIMARY KEY,
	id_productos_combos INT NOT NULL,
	id_adiciones INT NOT NULL,
    FOREIGN KEY (id_productos_combos) REFERENCES Productos_combos(id),
    FOREIGN KEY (id_adiciones) REFERENCES Adiciones(id)
);

-- Tabla Pedidos
CREATE TABLE Pedidos(
	id INT auto_increment PRIMARY KEY,
	id_menu INT NOT NULL,
    pedido VARCHAR(500) NOT NULL,
    FOREIGN KEY (id_menu) REFERENCES Menu(id)
);

-- Tabla Pedidos Vendidos
CREATE TABLE Pedidos_vendidos(
	id INT auto_increment PRIMARY KEY,
	id_pedido INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
	FOREIGN KEY (id_pedido) REFERENCES Pedidos(id)
);

-- Tabla Ventas
CREATE TABLE Ventas(
	id INT auto_increment PRIMARY KEY,
	id_pedido_vendido INT NOT NULL,
    ganancias DECIMAL(10,2) NOT NULL,
	FOREIGN KEY (id_pedido_vendido) REFERENCES Pedidos_vendidos(id)
);