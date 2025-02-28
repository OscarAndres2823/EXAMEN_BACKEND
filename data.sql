-- Crear la base de datos
CREATE DATABASE ConcesionarioVehiculos;
USE ConcesionarioVehiculos;

-- Tabla de Vehículos
CREATE TABLE Vehiculo (
    id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
    vin VARCHAR(17) NOT NULL UNIQUE,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anio INT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    color VARCHAR(30) NOT NULL,
    tipo_combustible ENUM('Gasolina', 'Diesel', 'Eléctrico', 'Híbrido') NOT NULL,
    tipo_transmision ENUM('Manual', 'Automático', 'CVT', 'Semi-automático') NOT NULL,
    estado ENUM('Nuevo', 'Usado') NOT NULL,
    disponible BOOLEAN DEFAULT TRUE,
    fecha_ingreso DATE NOT NULL,
    descripcion TEXT,
    CONSTRAINT chk_anio CHECK (anio >= 1900 AND anio <= YEAR(CURRENT_DATE)),
    CONSTRAINT chk_precio CHECK (precio > 0)
);

-- Tabla de Clientes
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE,
    direccion VARCHAR(255) NOT NULL,
    fecha_registro DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT chk_email CHECK (email LIKE '%@%.%')
);

-- Tabla de Vendedores
CREATE TABLE Vendedor (
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    num_empleado VARCHAR(10) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    CONSTRAINT chk_fecha_contratacion CHECK (fecha_contratacion <= CURRENT_DATE)
);

-- Tabla de Ventas
CREATE TABLE Venta (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    fecha_venta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(12, 2) NOT NULL,
    metodo_pago ENUM('Efectivo', 'Tarjeta de Crédito', 'Financiamiento', 'Transferencia') NOT NULL,
    observaciones TEXT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES Vendedor(id_vendedor),
    CONSTRAINT chk_total CHECK (total > 0)
);

-- Tabla de Detalle de Venta (para manejar relación muchos a muchos entre Venta y Vehículo)
CREATE TABLE DetalleVenta (
    id_detalle_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_vehiculo INT NOT NULL,
    precio_venta DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES Venta(id_venta),
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculo(id_vehiculo),
    CONSTRAINT chk_precio_venta CHECK (precio_venta > 0),
    CONSTRAINT uk_vehiculo_venta UNIQUE (id_vehiculo, id_venta)
);

-- Tabla de Mantenimiento
CREATE TABLE Mantenimiento (
    id_mantenimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_vehiculo INT NOT NULL,
    id_cliente INT,
    tipo_servicio ENUM('Preventivo', 'Correctivo', 'Revisión', 'Garantía') NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_servicio DATE NOT NULL,
    fecha_entrega DATE,
    costo DECIMAL(10, 2) NOT NULL,
    estado ENUM('Programado', 'En Proceso', 'Completado', 'Cancelado') NOT NULL DEFAULT 'Programado',
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculo(id_vehiculo),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT chk_costo CHECK (costo >= 0),
    CONSTRAINT chk_fechas_mantenimiento CHECK (fecha_entrega IS NULL OR fecha_entrega >= fecha_servicio)
);
