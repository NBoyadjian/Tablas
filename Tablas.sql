-- CREACIÓN DE LA BASE DE DATOS DE FÁBRICA DE CALZADOS
CREATE DATABASE purinky;

USE purinky;

-- CREACIÓN DE TABLAS
CREATE TABLE proveedores(
	id_proveedores INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL, 
    apellido VARCHAR(30) NOT NULL,
    razón_social VARCHAR(45) NOT NULL,
    email VARCHAR(45),
    web VARCHAR(45),id_facturación
    teléfono VARCHAR(20),
    domicilio VARCHAR(30) NOT NULL,
    localidad VARCHAR(30) NOT NULL
);

ALTER TABLE proveedores
ADD dni INT;

ALTER TABLE proveedores
MODIFY COLUMN dni INT NOT NULL;


CREATE TABLE insumos(
	código INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    sector VARCHAR(30) NOT NULL
);

ALTER TABLE insumos
ADD PRIMARY KEY (código);

CREATE TABLE empleados(
	id INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    dni VARCHAR(30) NOT NULL,
    cuit CHAR(11) NOT NULL,
    salario DECIMAL(8, 2) NOT NULL
);

ALTER TABLE empleados
ADD fecha_nacimiento DATE;

ALTER TABLE empleados
ADD domicilio VARCHAR(30),
ADD localidad VARCHAR(30);

ALTER TABLE empleados
ADD PRIMARY KEY(id);

ALTER TABLE empleados
RENAME COLUMN id TO id_empleados;

ALTER TABLE empleados
MODIFY COLUMN dni INT;

ALTER TABLE empleados
MODIFY COLUMN dni INT NOT NULL;

CREATE TABLE productos(
	id_productos INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    talle VARCHAR(30) NOT NULL,
    precio_unitario INT NOT NULL,
    costo_unitario DECIMAL(6, 2) NOT NULL
);

CREATE TABLE ventas(
	id INT NOT NULL PRIMARY KEY,
	descuentos INT,
    clientes INT,
    FOREIGN KEY(clientes) REFERENCES clientes(id)
);

ALTER TABLE ventas
ADD artículo VARCHAR(30),
ADD color VARCHAR(30),
ADD stock VARCHAR(30);

ALTER TABLE ventas
RENAME COLUMN id TO id_ventas;
    
CREATE TABLE clientes(
	id INT NOT NULL PRIMARY KEY,
    nombres VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    email VARCHAR(45),
    teléfono VARCHAR(30) NOT NULL,
    domicilio VARCHAR(30) NOT NULL,
    localidad VARCHAR(30) NOT NULL
);
    
ALTER TABLE clientes
ADD dni INT;

ALTER TABLE clientes
MODIFY COLUMN dni INT NOT NULL;

ALTER TABLE clientes
RENAME COLUMN nombres TO nombre;

ALTER TABLE clientes
RENAME COLUMN id TO id_clientes;


CREATE TABLE facturación(
	cobranzas VARCHAR(30),
    nota_de_crédito VARCHAR(30),
    nota_de_débitos VARCHAR(30),
    cheques VARCHAR(30),
    pagos VARCHAR(30)
);

-- CREACIÓN DE TABLAS ADICIONALES
CREATE TABLE aparadores(
	id_aparador INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    razón_social VARCHAR(45) NOT NULL,
    cuit CHAR(11) NOT NULL,
    costo INT,
    domicilio VARCHAR(30),
    localidad VARCHAR(30),
    id_código INT NOT NULL,
    PRIMARY KEY(id_aparador),
    FOREIGN KEY(id_código) REFERENCES insumos(id_código)
);

CREATE TABLE sectores(
	id_sector INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    empleados INT NOT NULL,
    productos INT NOT NULL,
    insumos_código INT NOT NULL,
    PRIMARY KEY(id_sector),
    FOREIGN KEY(empleados) REFERENCES empleados(id_empleados),
    FOREIGN KEY(productos) REFERENCES productos(id_productos),
    FOREIGN KEY(insumos_código) REFERENCES insumos(id_código)
);

CREATE TABLE viajantes(
	id_viajante INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    dni INT NOT NULL,
    cuit CHAR(11) NOT NULL,
    salario DECIMAL(8, 2) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    domicilio VARCHAR(30) NOT NULL,
    localidad VARCHAR(30) NOT NULL,
    teléfono VARCHAR(20) NOT NULL,
    email VARCHAR(45),
    clientes INT NOT NULL,
    zona VARCHAR(50) NOT NULL,
    ventas INT NOT NULL,
    PRIMARY KEY(id_viajante),
    FOREIGN KEY(clientes) REFERENCES clientes(id_clientes),
    FOREIGN KEY(ventas) REFERENCES ventas(id_ventas)
);

CREATE TABLE zonas(
	id_zona INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    viajante INT NOT NULL,
    PRIMARY KEY(id_zona),
    FOREIGN KEY(viajante) REFERENCES viajantes(id_viajante)
);

-- MODIFICACIONES DE LAS TABLAS
ALTER TABLE facturación
RENAME COLUMN nota_de_débitos TO nota_de_débito;

ALTER TABLE facturación
ADD id_clientes INT NOT NULL,
ADD id_proveedores INT NOT NULL;

ALTER TABLE facturación
ADD FOREIGN KEY(id_clientes) REFERENCES clientes(id_clientes);

ALTER TABLE facturación
ADD FOREIGN KEY(id_proveedores) REFERENCES proveedores(id_proveedores);

ALTER TABLE facturación
ADD composición_de_deudas DECIMAL(10,2);

ALTER TABLE insumos
RENAME COLUMN código TO id_código;

ALTER TABLE insumos
ADD id_sector INT NOT NULL;

ALTER TABLE insumos
MODIFY COLUMN sector INT NOT NULL;

ALTER TABLE insumos
DROP COLUMN id_sector;

ALTER TABLE empleados
ADD sector INT NOT NULL;

ALTER TABLE facturación
ADD id_facturación INT NOT NULL,
ADD PRIMARY KEY(id_facturación);

ALTER TABLE facturación
DROP COLUMN id_facturación;

ALTER TABLE facturación
ADD id_facturación INT NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY(id_facturación);

ALTER TABLE insumos
ADD FOREIGN KEY(sector) REFERENCES sectores(id_sector);

ALTER TABLE empleados
ADD FOREIGN KEY(sector) REFERENCES sectores(id_sector);

