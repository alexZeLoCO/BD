-- Clientes y empleados que viven en Oviedo     UNION

SELECT id_cliente,
       nombre,
       ciudad
FROM clientes
WHERE UPPER(ciudad) = 'OVIEDO'
UNION
SELECT id_empleado,
       nombre,
       ciudad
FROM empleados
WHERE UPPER(ciudad) = 'OVIEDO';

-- Ciudades donde viven tanto clientes como empleados      INTERSECT

SELECT ciudad
FROM clientes INTERSECT
SELECT ciudad
FROM empleados;

-- Ciudades donde viven clientes pero no empleados      EXCEPT

SELECT ciudad
FROM clientes
EXCEPT
SELECT ciudad
FROM empleados;

-- id_pedidos e importes para aquellos pedidos que consten de más de 3 productos diferentes

SELECT dp.id_pedido,
       SUM(dp.cantidad * p.precio) AS importe
FROM detalles_pedido AS dp
INNER JOIN productos p USING (id_producto)
GROUP BY (dp.id_pedido)
HAVING COUNT(DISTINCT dp.id_producto) > 3;

-- id_cliente, nombre e importe total gastado por el cliente.

SELECT c.id_cliente,
       c.nombre,
       SUM(dp.cantidad * pro.precio) AS importe
FROM clientes c
INNER JOIN pedidos p USING (id_cliente)
INNER JOIN detalles_pedido dp USING (id_pedido)
INNER JOIN productos pro USING (id_producto)
GROUP BY (c.id_cliente);

-- id_cliente, nombre e importe total de los 3 clientes que más han gastado.

SELECT c.id_cliente,
       c.nombre,
       SUM(dp.cantidad * pro.precio) AS importe
FROM clientes c
INNER JOIN pedidos p USING (id_cliente)
INNER JOIN detalles_pedido dp USING (id_pedido)
INNER JOIN productos pro USING (id_producto)
GROUP BY (c.id_cliente)
ORDER BY importe DESC
LIMIT (3);

-- Pedidos que han comprado todos los tipos de productos existentes.
-- TODO: Test

SELECT DISTINCT id_pedido
FROM detalles_pedido dp
WHERE NOT EXISTS (
                      (SELECT id_producto
                       FROM detalles_pedido
                       EXCEPT SELECT id_producto
                       FROM detalles_pedido dp2
                       WHERE dp.id_pedido = dp2.id_pedido ));


SELECT DISTINCT emp.id_empleado,
                emp.nombre
FROM empleados emp
INNER JOIN pedidos p1 USING (id_empleado)
WHERE NOT EXISTS
        (SELECT cli.id_cliente
         FROM pedidos
         INNER JOIN clientes cli USING (id_cliente)
         WHERE UPPER(cli.ciudad)='OVIEDO'
         EXCEPT SELECT cli.id_cliente
         FROM pedidos p2
         INNER JOIN clientes cli USING (id_cliente)
         WHERE UPPER(cli.ciudad)='OVIEDO'
             AND p1.id_empleado = p2.id_empleado );

-- productos que están en todos los pedidos

SELECT DISTINCT id_producto
FROM detalles_pedido dp
WHERE NOT EXISTS (
                      (SELECT id_pedido
                       FROM detalles_pedido
                       EXCEPT SELECT id_pedido
                       FROM detalles_pedido dp2
                       WHERE dp.id_producto = dp2.id_producto));

