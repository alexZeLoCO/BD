-- 1
-- 1.1 Crear tabla
CREATE TABLE operador (
    id_operador INTEGER PRIMARY KEY,
    nombre_operador VARCHAR(20) NOT NULL,
    lineas_operador INTEGER NOT NULL
);

-- 1.2 Popular tabla
INSERT INTO operador VALUES (1, 'SKT', 40000000);
INSERT INTO operador VALUES (2, 'NTTDOCOMO', 31120000);
INSERT INTO operador VALUES (3, 'VERIZON', 87450000);
INSERT INTO operador VALUES (4, 'DT', 37325000);
INSERT INTO operador VALUES (5, 'TIM', 28945000);
INSERT INTO operador VALUES (6, 'CLARO', 51637000);

-- Test
SELECT * FROM operador;

-- 1.3 Funcion lineas <= 38M o lineas >= 80M
CREATE OR REPLACE FUNCTION operador_lineas () RETURNS TABLE (nombre_operador VARCHAR(20)) AS $$
BEGIN
    RETURN QUERY
    SELECT operador.nombre_operador
    FROM operador
    WHERE operador.lineas_operador <= 38000000 
    OR operador.lineas_operador >= 80000000;
END;
$$ LANGUAGE PLPGSQL;

-- Test
SELECT operador_lineas();

-- 2
-- 2.1 Funcion abortar si delete y lineas >= 35M
CREATE OR REPLACE FUNCTION delete_operador () RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'DELETE' AND old.lineas_operador >= 35000000
    THEN 
        RAISE NOTICE 'Operacion no autorizada, consulte al administrador de la base de datos.';
        RETURN NULL;
    END IF;
    RETURN new;
END;
$$ LANGUAGE PLPGSQL;

-- 2.2 Trigger antes de delete
CREATE TRIGGER delete_operador_trigger 
BEFORE DELETE ON operador
FOR EACH ROW EXECUTE PROCEDURE delete_operador();

-- Test
INSERT INTO operador VALUES (7, 'Alex', 50000000);
INSERT INTO operador VALUES (8, 'Alex', 27);

DELETE FROM operador WHERE operador.id_operador=7;
DELETE FROM operador WHERE operador.id_operador=8;

DROP TRIGGER delete_operador_trigger
ON operador;

DELETE FROM operador WHERE operador.id_operador=7;

CREATE TRIGGER delete_operador_trigger 
BEFORE DELETE ON operador
FOR EACH ROW EXECUTE PROCEDURE delete_operador();

-- 3
-- 3.1 Funcion mostrar operacion e id
CREATE OR REPLACE FUNCTION deup_original () RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'DELETE'
    THEN
        -- Delete ==> Return old
        RAISE NOTICE 'Se ha realizado una operacion % en la tabla ''origen'', en el id %.', TG_OP, old.id;
        RETURN old;
    ELSE
        -- Non-Delete ==> Return new 
        RAISE NOTICE 'Se ha realizado una operacion % en la tabla ''origen'', en el id %.', TG_OP, new.id;
        RETURN new;
    END IF;
END;
$$ LANGUAGE PLPGSQL;

-- 3.2 Trigger tras delete o insert
CREATE TRIGGER deup_original_trigger
AFTER INSERT OR DELETE ON origen
FOR EACH ROW EXECUTE PROCEDURE deup_original ();

-- test
INSERT INTO origen VALUES (309, 'Espanna');
DELETE FROM origen WHERE id=309;

-- 4
-- 4.1 Procedimiento listar nombre de componentes y lugares de origenes
CREATE OR REPLACE PROCEDURE listar_co_proyectados () AS $$
DECLARE R VARCHAR(20);
BEGIN
    -- nombres de componentes
    RAISE NOTICE 'Tabla ''componente'' proyectada por ''nombre''';
    FOR R IN 
        SELECT componente.nombre
        FROM componente
    LOOP
        RAISE NOTICE '%', R;
    END LOOP;

    -- lugares de origenes
    RAISE NOTICE 'Tabla ''origen'' proyectada por ''lugar''';
    FOR R IN 
        SELECT origen.lugar
        FROM origen 
    LOOP
    RAISE NOTICE '%', R;
    END LOOP;
END;
$$ LANGUAGE PLPGSQL;

-- test
CALL listar_co_proyectados();

-- 5
-- 5.1 Funcion nombreMovil idMovil componenteId componenteNombre de 'apple'
CREATE OR REPLACE FUNCTION apple () RETURNS TABLE (nombre_movil VARCHAR(20), id_movil INTEGER, id_componente INTEGER, nombre_componente VARCHAR(20)) AS $$
BEGIN
    RETURN QUERY
    SELECT movil.nombre, movil.id, componente.id, componente.nombre
    FROM movil
    JOIN movilComponente ON movil.id = movilComponente.id_movil
    JOIN componente ON movilComponente.id_componente = componente.id
    WHERE LOWER(movil.nombre) = 'apple';
END;
$$ LANGUAGE PLPGSQL;

-- test
SELECT apple ();