Base de Datos para Concesionario de Vehículos

Descripción
Diseñar una base de datos para un concesionario de vehículos que gestione la información sobre los vehículos en stock, clientes, ventas, y servicios de mantenimiento. La base de datos debe permitir registrar y gestionar vehículos, vendedores, clientes, transacciones de ventas y servicios realizados. Los estudiantes deben crear un diagrama UML E-R que represente la estructura de la base de datos y entregar una documentación detallada que explique las decisiones de diseño, las relaciones entre las tablas y las restricciones impuestas.
Estructura de la Base de Datos

La base de datos está compuesta por las siguientes tablas:

Marca: Contiene las marcas de los vehículos.

Modelo: Define los modelos de vehículos asociados a una marca.

Vehículo: Registra los vehículos disponibles en el concesionario.

Cliente: Almacena información sobre los clientes.

Vendedor: Contiene datos de los vendedores.

Venta: Representa las transacciones de venta de vehículos.

Detalle_Venta: Relaciona cada venta con los vehículos adquiridos.

Tipo_Servicio: Lista los tipos de mantenimiento disponibles.

Mantenimiento: Registra los mantenimientos realizados a los vehículos.

Reglas y Restricciones

Cada vehículo tiene un VIN único.

Un vehículo vendido cambia automáticamente su estado a no disponible.

Un cliente puede realizar varias compras y solicitar mantenimientos.

Un vendedor puede gestionar múltiples ventas.


Instalación

Crear la base de datos en MySQL o un sistema compatible.

Ejecutar el archivo SQL proporcionado para la creación de tablas.

Cargar datos iniciales según sea necesario.