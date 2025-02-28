CREATE DATABASE CampusCar;
USE CampusCar;

CREATE TABLE PERSONA (
    id_persona INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(150) UNIQUE NOT NULL,
    fecha_registro DATE NOT NULL
);

CREATE TABLE CLIENTE (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    id_persona INT UNIQUE NOT NULL,
    tipo_cliente VARCHAR(50) NOT NULL,
    num_compras INT DEFAULT 0,
    ultima_compra DATE,
    FOREIGN KEY (id_persona) REFERENCES PERSONA(id_persona)
);

CREATE TABLE DIRECCION (
    id_direccion INT PRIMARY KEY AUTO_INCREMENT,
    id_persona INT NOT NULL,
    calle VARCHAR(255) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL,
    codigo_postal VARCHAR(20) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    direccion_principal BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_persona) REFERENCES PERSONA(id_persona)
);

CREATE TABLE VENDEDOR (
    id_vendedor INT PRIMARY KEY AUTO_INCREMENT,
    id_persona INT UNIQUE NOT NULL,
    num_empleado VARCHAR(50) UNIQUE NOT NULL,
    fecha_contratacion DATE NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    departamento VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_persona) REFERENCES PERSONA(id_persona)
);

CREATE TABLE MARCA (
    id_marca INT PRIMARY KEY AUTO_INCREMENT,
    nombre_marca VARCHAR(100) NOT NULL,
    pais_origen VARCHAR(100) NOT NULL
);

CREATE TABLE MODELO_VEHICULO (
    id_modelo INT PRIMARY KEY AUTO_INCREMENT,
    id_marca INT NOT NULL,
    nombre_modelo VARCHAR(100) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    tipo_vehiculo VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_marca) REFERENCES MARCA(id_marca)
);

CREATE TABLE VEHICULO (
    id_vehiculo INT PRIMARY KEY AUTO_INCREMENT,
    id_modelo INT NOT NULL,
    vin VARCHAR(50) UNIQUE NOT NULL,
    anio INT NOT NULL,
    precio_base DECIMAL(10,2) NOT NULL,
    color VARCHAR(50) NOT NULL,
    tipo_combustible ENUM('Gasolina', 'Diésel', 'Eléctrico', 'Híbrido') NOT NULL,
    tipo_transmision ENUM('Manual', 'Automático') NOT NULL,
    estado ENUM('Nuevo', 'Usado', 'Reservado', 'Vendido') NOT NULL,
    disponible BOOLEAN DEFAULT TRUE,
    fecha_ingreso DATE NOT NULL,
    FOREIGN KEY (id_modelo) REFERENCES MODELO_VEHICULO(id_modelo)
);

CREATE TABLE CARACTERISTICA (
    id_caracteristica INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(100) NOT NULL
);

CREATE TABLE VEHICULO_CARACTERISTICA (
    id_vehiculo_carac INT PRIMARY KEY AUTO_INCREMENT,
    id_vehiculo INT NOT NULL,
    id_caracteristica INT NOT NULL,
    valor VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_vehiculo) REFERENCES VEHICULO(id_vehiculo),
    FOREIGN KEY (id_caracteristica) REFERENCES CARACTERISTICA(id_caracteristica)
);

CREATE TABLE VENTA (
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    fecha_venta DATETIME NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    impuestos DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    metodo_pago ENUM('Efectivo', 'Tarjeta de Crédito', 'Transferencia') NOT NULL,
    observaciones TEXT,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES VENDEDOR(id_vendedor)
);

CREATE TABLE DETALLE_VENTA (
    id_detalle_venta INT PRIMARY KEY AUTO_INCREMENT,
    id_venta INT NOT NULL,
    id_vehiculo INT NOT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,
    descuento DECIMAL(10,2) DEFAULT 0,
    notas_adicionales TEXT,
    FOREIGN KEY (id_venta) REFERENCES VENTA(id_venta),
    FOREIGN KEY (id_vehiculo) REFERENCES VEHICULO(id_vehiculo)
);

CREATE TABLE TIPO_SERVICIO (
    id_tipo_servicio INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    requiere_piezas BOOLEAN DEFAULT FALSE
);

CREATE TABLE MANTENIMIENTO (
    id_mantenimiento INT PRIMARY KEY AUTO_INCREMENT,
    id_vehiculo INT NOT NULL,
    id_cliente INT,
    id_tipo_servicio INT NOT NULL,
    descripcion_detallada TEXT NOT NULL,
    fecha_servicio DATE NOT NULL,
    fecha_entrega DATE,
    costo_mano_obra DECIMAL(10,2) NOT NULL,
    costo_piezas DECIMAL(10,2) DEFAULT 0,
    costo_total DECIMAL(10,2) NOT NULL,
    estado ENUM('Pendiente', 'En Proceso', 'Completado', 'Cancelado') NOT NULL,
    FOREIGN KEY (id_vehiculo) REFERENCES VEHICULO(id_vehiculo),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (id_tipo_servicio) REFERENCES TIPO_SERVICIO(id_tipo_servicio)
);

CREATE TABLE PIEZA (
    id_pieza INT PRIMARY KEY AUTO_INCREMENT,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

CREATE TABLE MANTENIMIENTO_PIEZA (
    id_mant_pieza INT PRIMARY KEY AUTO_INCREMENT,
    id_mantenimiento INT NOT NULL,
    id_pieza INT NOT NULL,
    cantidad INT NOT NULL,
    precio_aplicado DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_mantenimiento) REFERENCES MANTENIMIENTO(id_mantenimiento),
    FOREIGN KEY (id_pieza) REFERENCES PIEZA(id_pieza)
);

CREATE TABLE HISTORIAL_PRECIO_VEHICULO (
    id_historial INT PRIMARY KEY AUTO_INCREMENT,
    id_vehiculo INT NOT NULL,
    precio_anterior DECIMAL(10,2) NOT NULL,
    precio_nuevo DECIMAL(10,2) NOT NULL,
    fecha_cambio DATE NOT NULL,
    motivo VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_vehiculo) REFERENCES VEHICULO(id_vehiculo)
);
