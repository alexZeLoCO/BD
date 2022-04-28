-- 1 Crear dominios email y postcode

create domain dominio_email as text check (value ~'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');


create domain dominio_postcode as text check (value ~'^\d{5}$');

-- 2 Inlcuir columnas email y postcode en fabricante con sus respectivos dominios

ALTER TABLE fabricante ADD COLUMN email dominio_email;


ALTER TABLE fabricante ADD COLUMN postcode dominio_postcode;

-- 3 Actualizar tabla fabricante

UPDATE fabricante
set email='customerservice@kingston.eu'
WHERE id_fabricante = 100;


UPDATE fabricante
set postcode='92200'
WHERE id_fabricante = 100;


UPDATE fabricante
set email='spainsupport@digikey.com'
WHERE id_fabricante = 101;


UPDATE fabricante
set postcode='44640'
WHERE id_fabricante = 101;


UPDATE fabricante
set email='intelsupport@intel.com'
WHERE id_fabricante = 102;


UPDATE fabricante
set postcode='55232'
WHERE id_fabricante = 102;


UPDATE fabricante
set email='amdcustomer@amd.com'
WHERE id_fabricante = 103;


UPDATE fabricante
set postcode='34567'
WHERE id_fabricante = 103;


UPDATE fabricante
set email='teslasupport@tesla.com'
WHERE id_fabricante = 104;


UPDATE fabricante
set postcode='39472'
WHERE id_fabricante = 104;

-- 4 Crea dominio dominio_anios_garantia.

CREATE DOMAIN dominio_anios_garantia AS INTEGER CHECK (VALUE > 0
                                                       AND VALUE < 4);


ALTER TABLE pc ADD COLUMN garantia dominio_anios_garantia DEFAULT 2;

-- 7.4 Discos con precio mayor a la media

SELECT AVG(disco.precio)
FROM disco;


SELECT capacidad,
       precio
FROM disco
WHERE disco.precio >
        (SELECT AVG(d.precio)
         FROM disco d);


CREATE
OR REPLACE function precioDiscos () RETURNS table (capacidad varchar(30),
                                                             precio numeric) as $$

    BEGIN
    return query
        SELECT disco.capacidad,
            disco.precio
            FROM disco
        WHERE disco.precio >
            (SELECT AVG(d.precio)
            FROM disco d);
    end;
$$ language plpgsql;

-- 7.5 Fabricantes que hacen mas de un tipo de disco

SELECT id_fabricante
FROM disco
GROUP BY id_fabricante
HAVING count(id_disco) > 1;


SELECT fabricante.nombre
FROM fabricante
WHERE fabricante.id_fabricante IN
        (SELECT id_fabricante
         FROM disco
         GROUP BY id_fabricante
         HAVING count(id_disco) > 1);


CREATE OR REPLACE function getinfofabricante () RETURNS table (nombre VARCHAR(100)) AS $$
BEGIN
RETURN query
SELECT fabricante.nombre
FROM fabricante
WHERE fabricante.id_fabricante IN
        (SELECT id_fabricante
         FROM disco
         GROUP BY id_fabricante
         HAVING count(id_disco) > 1);
         END;
         $$ language plpgsql;

-- 7.6 Informacion de pc con la gpu mas barata

SELECT MIN(tarjeta_grafica.precio)
FROM tarjeta_grafica;


SELECT *
FROM pc
JOIN tarjeta_grafica USING (id_tarjeta_grafica)
WHERE tarjeta_grafica.precio =
        (SELECT MIN(tarjeta_grafica.precio)
         FROM tarjeta_grafica);


CREATE OR REPLACE function getinfopcs () RETURNS table (id integer, id_cpu integer, id_disco integer, id_memoria integer, id_tarjeta_grafica integer) AS $$

BEGIN
RETURN query
SELECT pc.id_pc, pc.id_cpu, pc.id_disco, pc.id_memoria, pc.id_tarjeta_grafica
FROM pc
JOIN tarjeta_grafica USING (id_tarjeta_grafica)
WHERE tarjeta_grafica.precio =
        (SELECT MIN(tarjeta_grafica.precio)
         FROM tarjeta_grafica);
        END;
         $$ language plpgsql;

-- 8 Trigger presenta_info_pc. Presenta un mensaje cada vez que se modifique la tabla pc

CREATE OR REPLACE FUNCTION presentaInfoPc () RETURNS TRIGGER as $$
BEGIN
    raise notice 'Se ha realizado una accion en la tabla pc';
    return null;
    end;
    $$language plpgsql;


CREATE TRIGGER presenta_info_pc AFTER
INSERT
OR
DELETE
OR
UPDATE ON pc EXECUTE PROCEDURE presentaInfoPc();


INSERT INTO pc
VALUES (8,
        501,
        602,
        300,
        702,
        3);


UPDATE pc
SET id_cpu=500
WHERE id_pc=8;


DELETE
FROM pc
WHERE id_pc=8;

-- 5 division: Aquellos proveedores que suministran todas las memorias
 -- De los proveedores extraigo los que no proveen todas las memorias
-- De los proveedores extraigo los que no estan en la lista de los que proveen todas las memorias
-- De los proveedores extraigo los que no estan en la lista de los que la cuenta de memorias no es igual al total de memorias
 -- 1. Total de memorias

SELECT id_tipo_memoria
FROM memoria
GROUP BY id_tipo_memoria;

-- 2. Total de memorias proveidas por proveedor

SELECT memoria.id_tipo_memoria
FROM proveedor_memoria
JOIN memoria USING (id_memoria)
WHERE proveedor_memoria.id_proveedor = 800;

-- 3. Proveedores que proveen el total de memorias.

SELECT id_proveedor
FROM proveedor_memoria
GROUP BY (id_proveedor)
HAVING count(id_tipo_memoria) IN
    (SELECT count(id_memoria)
     FROM memoria
     GROUP BY id_tipo_memoria);

-- NOTAS: 1 2 3 4 7.4 7.5 7.6 8 5