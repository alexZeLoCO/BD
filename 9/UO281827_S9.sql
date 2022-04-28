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
OR REPLATE function precioDiscos () { }