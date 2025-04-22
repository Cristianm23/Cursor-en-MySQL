-- use myfood;
delimiter //

CREATE PROCEDURE clientes_altos()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE v_cedula INT;
  DECLARE v_puntaje INT;
  DECLARE v_paginaWeb VARCHAR(60);
  DECLARE v_direccion VARCHAR(45);

  DECLARE cursor_clientes CURSOR FOR
    SELECT cedula, puntaje, paginaWeb, direccion
    FROM clientes
    WHERE puntaje > 5;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cursor_clientes;

  read_loop: LOOP
    FETCH cursor_clientes INTO v_cedula, v_puntaje, v_paginaWeb, v_direccion;
    IF done THEN
      LEAVE read_loop;
    END IF;

    -- Aquí puedes usar SELECT en lugar de PRINT
    SELECT CONCAT('Cliente evaluado: ', v_cedula, ', Puntaje: ', v_puntaje, ', Dirección: ', v_direccion) AS resultado;
  END LOOP;

  CLOSE cursor_clientes;
END //

DELIMITER ;
CALL clientes_altos();

