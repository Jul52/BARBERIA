drop database if exists BarberiaDB;
create database BarberiaDB;
use BarberiaDB;

CREATE TABLE TipoDocumento (
	idDocumento int PRIMARY KEY auto_increment,
	tipoDoc VARCHAR (20) NOT NULL
);

CREATE TABLE Cliente (
	idCliente int PRIMARY KEY auto_increment,
	nombre VARCHAR (100) NOT NULL,
	teléfono VARCHAR (15) NOT NULL,
	email VARCHAR (100) NOT NULL,
	numeroDoc VARCHAR (20) NOT NULL,
	idDocumento int
);

CREATE TABLE Especialidad (
	idEspecialidad int PRIMARY KEY auto_increment,
    nombre VARCHAR (50) NOT NULL
);

CREATE TABLE Barbero (
	idBarbero int PRIMARY KEY auto_increment,
	nombre VARCHAR (100) NOT NULL,
    idEspecialidad INT NOT NULL,
	FOREIGN KEY (idEspecialidad) references Especialidad(idEspecialidad)
);

CREATE TABLE Horario (
	idHorario int PRIMARY KEY auto_increment,
	idBarbero int,
	diaSemana VARCHAR (15) NOT NULL,
	fecha DATE NOT NULL,
	hora TIME NOT NULL
);

CREATE TABLE Cita (
	idCita int PRIMARY KEY auto_increment,
	idCliente int NOT NULL,
	idBarbero int NOT NULL,
	fecha DATE NOT NULL,
	Hora TIME NOT NULL
);

create table MetodoPago (
idMetodoPago tinyint (3) primary key auto_increment,
metodoPago varchar (20)
);

CREATE TABLE Factura (
	idFactura int PRIMARY KEY auto_increment,
	idCliente int NOT NULL,
	fechaEmision DATE NOT NULL,
	idMetodoPago TINYINT (3) NOT NULL,
	total DECIMAL (10,2) NOT NULL
);

CREATE TABLE Producto (
	idProducto INTEGER (10) PRIMARY KEY auto_increment,
	nombre VARCHAR (100) NOT NULL,
	precio DECIMAL (10,2) NOT NULL
);
CREATE TABLE Servicio (
	idServicio INTEGER (10) PRIMARY KEY,
	nombre VARCHAR (100) NOT NULL,
	precio DECIMAL (10,2) NOT NULL
);

CREATE TABLE DetalleFactura (
	idDetalleFactura INTEGER (10) PRIMARY KEY auto_increment,
	idFactura INTEGER (10) NOT NULL,
	idProducto INTEGER (10) NULL,
	idServicio INTEGER (10) NULL, 
	cantidad INTEGER (10) NOT NULL,
	subTotal DECIMAL (10,2) NOT NULL
);

ALTER TABLE Cliente ADD constraint fk_cliente_tipoDoc 
foreign key (idDocumento) references TipoDocumento(idDocumento);

ALTER TABLE Horario ADD constraint fk_idBarbero foreign key (idBarbero) references Barbero(idBarbero);

ALTER TABLE Cita ADD constraint fk_idCliente foreign key (idCliente) references Cliente(idCliente);

ALTER TABLE Cita ADD constraint fk_cita_idBarbero foreign key (idBarbero) references Barbero(idBarbero);

ALTER TABLE Factura ADD constraint fkIdCliente foreign key (idCliente) references Cliente(idCliente);

ALTER TABLE Factura ADD constraint fk_idmetodoPago foreign key (idMetodoPago) references MetodoPago(idMetodoPago);

ALTER TABLE DetalleFactura ADD constraint fk_idFactura foreign key (idFactura) references Factura(idFactura);

ALTER TABLE DetalleFactura ADD constraint fk_idProducto foreign key (idProducto) references Producto(idProducto);

ALTER TABLE DetalleFactura ADD constraint fk_idServicio foreign key (idServicio) references Servicio(idServicio);

ALTER TABLE barbero ADD constraint fk_idEspecialidad foreign key (idEspecialidad) references Especialidad(idEspecialidad);


RENAME table cliente TO Usuarios;

RENAME TABLE barbero to trabajador;

ALTER TABLE Usuarios change column email correo varchar(40);

ALTER TABLE Usuarios ADD fechaNacim date;