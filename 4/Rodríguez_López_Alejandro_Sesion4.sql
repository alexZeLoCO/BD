/* Consulta 1: Obtener lista completa de clientes */
SELECT *
FROM clientes;

/* Consulta 2: Obtener nombres y ciudades de clientes de Gijón ó Oviedo */
SELECT nombre, ciudad
FROM clientes
WHERE ciudad = 'GIJON'
OR ciudad = 'OVIEDO';

/* Consulta 3: Obtener nombres y ciudades de Gijón ó Oviedo independientemente de si están escritos con mayusculas ó minúsculas */
SELECT nombre, ciudad
FROM clientes
WHERE UPPER(ciudad) = 'GIJON'
OR UPPER(ciudad) = 'OVIEDO';

/* Consulta 4: Mostar los productos, sus precios sin y con IVA (16%) y las existencias de aquellos cuyo precio esté entre 4 y 6. */
SELECT nombre, precio, precio*1.16 AS PrecioIva, existencias
FROM productos
WHERE precio >= 4
AND precio <= 6;

/* Consulta 5: Insertar un producto (con información completa). Después, borra el producto introducido. */
INSERT INTO productos VALUES (11, 'UN PRODUCTO', 120, 5);
SELECT * FROM productos;	-- Con UN PRODUCTO
DELETE FROM productos WHERE id_producto = 11;
SELECT * FROM productos;	-- Sin UN PRODUCTO

/* Consulta 6: Insertar un producto (con información incompleta) del que no se conoce el dato de las existencias. */
INSERT INTO productos (id_producto, nombre, precio) VALUES (11, 'UN PRODUCTO', 5);
SELECT * FROM productos;	-- Con UN PRODUCTO
DELETE FROM productos WHERE id_producto = 11;
SELECT * FROM productos;	-- Sin UN PRODUCTO

/* Consulta 7: Aumentar un 20% el precio de los productos con precio actual de 5. Investiga el uso de UPDATE. */
UPDATE productos
SET precio = precio*1.2
WHERE precio = 5;
SELECT * FROM productos;

/* Consulta 8: Obtener parejas de nombres de clientes que viven en la misma ciudad. */
SELECT DISTINCT c1.nombre AS cliente_a, c2.nombre AS cliente_b
FROM clientes c1, clientes c2
WHERE c1.ciudad = c2.ciudad
AND NOT c1.id_cliente = c2.id_cliente;

/* Consulta 9: Obtener los nombres de clientes y empleados que viven en la misma ciudad. */
SELECT DISTINCT c1.nombre AS cliente_a, c2.nombre AS cliente_b
FROM clientes c1, clientes c2
WHERE c1.ciudad = c2.ciudad
AND NOT c1.id_cliente = c2.id_cliente
UNION
SELECT DISTINCT e1.nombre AS empleado_a, e2.nombre AS empleado_b
FROM empleados e1, empleados e2
WHERE e1.ciudad = e2.ciudad
AND NOT e1.id_empleado = e2.id_empleado;

/* Consulta 10: Obtener los clientes (con todos sus datos) que hayan solicitado pedidos junto con toda la información de éstos. */
SELECT * FROM clientes INNER JOIN pedidos USING(id_cliente);

/* Consulta 11: Obtener los clientes (id_cliente y nombre) y sus pedidos (id_pedido y fecha) para pedidos realizados con posterioridad a ‘2009-12-31’. */
SELECT id_cliente, nombre, pedidos.id_pedido, pedidos.fecha_pedido
FROM clientes INNER JOIN pedidos USING(id_cliente)
WHERE pedidos.fecha_pedido > '2009-12-31';

/* Consulta 12: Obtener los clientes (id_cliente y nombre) y sus pedidos (id_pedido y fecha) para pedidos realizados en Enero de 2008, y muestra los empleados que los atendieron (id_empleado y nombre). Investiga el uso de la orden EXTRACT. */
SELECT clientes.id_cliente, clientes.nombre, pedidos.id_pedido, pedidos.fecha_pedido, empleados.nombre
FROM clientes
INNER JOIN pedidos USING (id_cliente)
INNER JOIN empleados USING (id_empleado)
WHERE EXTRACT (year from pedidos.fecha_pedido) = 2008
AND EXTRACT (month from pedidos.fecha_pedido) = 01;

/* Consulta 13: Obtener los nombres de los clientes y sus pedidos (id_pedido) que hayan sido realizados con posterioridad al día ‘2008-09-01’ y atendidos por empleados de ‘Oviedo’. */

/* Consulta 14: Obtener todos los clientes (id_cliente y nombre) y la cantidad de pedidos que han solicitado. */

/* Consulta 15: Obtener todos los clientes y todos los empleados aunque no hubieran solicitado/servido ningún pedido. Mostrar nombre del cliente solicitante del pedido, nombre del empleado que sirvió el pedido y el identificador del pedido. */

/* Consulta 16: Mostrar los productos (identificador y nombre) que fueron servidos por el empleado ‘Juan’ */

/* Consulta 17: Mostrar los productos (identificador y nombre) que NO fueron servidos por el empleado ‘Juan’ */

/* Consulta 18: Seleccionar los clientes cuyo nombre empiece por la letra ‘J’ o ‘j’. Investiga el uso de la orden LIKE */
SELECT *
FROM clientes
WHERE UPPER(clientes.nombre) LIKE 'J%';

/* Consulta 19: Seleccionar los clientes cuyo nombre acabe por ‘DO’ independientemente de mayúsculas o minúsculas */
SELECT *
FROM clientes
WHERE UPPER(clientes.nombre) LIKE '%DO';

/* Consulta 20: Seleccionar los clientes cuyo nombre contenga ’AN’ independientemente de mayúsculas o minúsculas */
SELECT *
FROM clientes
WHERE UPPER(clientes.nombre) LIKE '%AN%';

/* Consulta 21: Obtener los clientes (id_cliente y nombre) que no han realizado ningún pedido */
SELECT clientes.id_cliente, clientes.nombre
FROM clientes
EXCEPT
SELECT clientes.id_cliente, clientes.nombre
FROM clientes
INNER JOIN pedidos USING (id_cliente);

/* Consulta 22: Obtener los clientes (id_cliente y nombre) o los empleados (id_empleado y nombre) que viven en ‘Oviedo’ */

/* Consulta 23: Obtener las ciudades donde viven tanto clientes y empleados */

/* Consulta 24: Obtener las ciudades donde viven clientes y no viven empleados */

/* Consulta 25: Obtener los identificadores de los clientes que hayan hecho algún pedido con al menos todos los productos que pidió el cliente con id_cliente=2 */

/* Consulta 26: Obtener los pedidos (id_pedido) que constan de todos los productos. */

/* Consulta 27: Obtener los pedidos (id_pedido) que constan de todos los productos (con la construcción ‘NOT EXISTS (B EXCEPT A)’ ) */

/* Consulta 28: Obtener los productos (id_producto y nombre) que constan en todos los pedidos */
SELECT DISTINCT id_producto
FROM detalles_pedido dp
WHERE NOT EXISTS (
SELECT id_pedido FROM detalles_pedido
EXCEPT (
SELECT id_pedido FROM detalles_pedido dp2
WHERE dp.id_producto = dp2.id_producto)
);

/* Consulta 29: Obtener los empleados (identificador y nombre) que han emitido pedidos a todos los clientes de Oviedo. */
SELECT DISTINCT id_empleado, e.nombre
FROM pedidos p1
WHERE NOT EXISTS (
SELECT id_cliente
FROM pedidos
INNER JOIN clientes USING (id_cliente)
WHERE cli.ciudad = 'OVIEDO')
EXCEPT (
SELECT id_cliente
FROM pedidos p2
INNER JOIN clientes cli
USING (id_cliente)
WHERE cli.ciudad = 'OVIEDO'
AND p1.id_empleado=p2.id_empleado
);

/* Consulta 30: Obtener los identificadores y los nombres de los clientes y el nº de pedidos realizados por los mismos (que contengan productos, es decir, que existan en detalles_pedido) */

/* Consulta 31: Obtener el nº de pedidos del cliente con id-cliente=1 */

/* Consulta 32: Obtener los identificadores de los pedidos junto con el importe de los mismos para aquellos pedidos que consten de más de 3 productos diferentes. */
