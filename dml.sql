INSERT INTO tipodocumento (tipoDoc) values("CC");
INSERT INTO tipodocumento (tipoDoc) values("TI"),("PASAPORTE"),("CE");


INSERT INTO Usuarios (nombre, teléfono, correo, numeroDoc, idDocumento, fechaNacim) values("Santiago", "3161500263", "santiago.mendezpd@gmail.com", "1016951011", "1", "25/03/05"), ("Cassandra", "3141690182", "cass@gmail.com", "1016951011", "4", "00/04/19");

INSERT INTO Especialidad (nombre) values("Corte Basico");
INSERT INTO Especialidad (nombre) values("Corte Cabello Largo");
INSERT INTO Especialidad (nombre) values("Manicure o Pedicure");

INSERT INTO trabajador (nombre, idEspecialidad) values("Juliana", 1),("Santiago", 2),("Alfredo", 3);

INSERT INTO Horario (diaSemana, fecha, hora) values("Jueves", "25/05/28", "8:00");

INSERT INTO metodopago values(1,"Efectivo"), (2, "PSE"), (3,"Tarjeta");

INSERT INTO producto values(1,"Shampoo para calvos", "300000"), (2,"Crema de peinar", "25500");

INSERT INTO servicio values(1, "Corte de cabello", "20000"), (2,"Tintura", "250000"), (3, "Manicure y pedicure", "18000"); 

/* 
select * from tipodocumento;
select * from Trabajador;
select * from Usuarios;	
select * from Horario;
select * from metodopago;
select * from Factura;
select * from servicio;
select * from cita;
select * from especialidad;
*/