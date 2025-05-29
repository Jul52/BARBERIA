DELIMITER //
CREATE PROCEDURE insertar_detalle_factura(
    IN factura_id INT,
    IN prod_id INT,
    IN serv_id INT,
    IN cantidad INT
)
BEGIN
    DECLARE subtotal_valor DECIMAL(10,2);

    
    IF prod_id IS NOT NULL THEN
        SELECT precio INTO subtotal_valor FROM Producto WHERE idProducto = prod_id;
    ELSEIF serv_id IS NOT NULL THEN
        SELECT precio INTO subtotal_valor FROM Servicio WHERE idServicio = serv_id;
    END IF;

    SET subtotal_valor = subtotal_valor * cantidad;

    
    INSERT INTO DetalleFactura (
        idFactura, idProducto, idServicio, cantidad, subTotal
    ) VALUES (
        factura_id, prod_id, serv_id, cantidad, subtotal_valor
    );
END //
DELIMITER ;

-- Trigger: Actualizar total después de insertar detalle
DELIMITER //
CREATE TRIGGER actualizar_total_factura_after_insert
AFTER INSERT ON DetalleFactura
FOR EACH ROW
BEGIN
    UPDATE Factura
    SET total = (
        SELECT SUM(subTotal) FROM DetalleFactura WHERE idFactura = NEW.idFactura
    )
    WHERE idFactura = NEW.idFactura;
END //
DELIMITER ;

INSERT INTO Factura (idFactura, idCliente, fechaEmision, idMetodoPago, total)
VALUES (1, 1, '2025-04-05', 1, 0);

CALL insertar_detalle_factura(1, 1, NULL, 2); 
CALL insertar_detalle_factura(1, 2, NULL, 1);

SELECT * FROM DetalleFactura WHERE idFactura = 1;
SELECT * FROM Factura WHERE idFactura = 1;