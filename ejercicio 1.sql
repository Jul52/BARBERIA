-- Función: Verificar disponibilidad del barbero
DELIMITER //
CREATE FUNCTION validar_disponibilidad_barbero(barbero_id INT, fecha DATE, hora TIME)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE disponible BOOLEAN DEFAULT TRUE;
    IF EXISTS (
        SELECT 1 FROM Cita
        WHERE idBarbero = barbero_id AND fecha = fecha AND Hora = hora
    ) THEN
        SET disponible = FALSE;
    END IF;
    RETURN disponible;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE agendar_cita(
    IN cliente_id INT,
    IN barbero_id INT,
    IN cita_fecha DATE,
    IN cita_hora TIME
)
BEGIN
    IF validar_disponibilidad_barbero(barbero_id, cita_fecha, cita_hora) THEN
        INSERT INTO Cita (idCita, idCliente, idBarbero, fecha, Hora)
        VALUES (NULL, cliente_id, barbero_id, cita_fecha, cita_hora);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El barbero no está disponible a esa hora.';
    END IF;
END //
DELIMITER ;

-- Trigger
DELIMITER //
CREATE TRIGGER evitar_citas_superpuestas
BEFORE INSERT ON Cita
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM Cita
        WHERE idBarbero = NEW.idBarbero AND fecha = NEW.fecha AND Hora = NEW.Hora
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ya existe una cita programada a esta hora para este barbero.';
    END IF;
END //
DELIMITER ;

CALL agendar_cita(1, 1, '2025-04-05', '10:00:00');

select * from cita