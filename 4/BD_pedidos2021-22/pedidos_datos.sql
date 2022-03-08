\c pedidos;

DELETE FROM detalles_pedido;
DELETE FROM pedidos;
DELETE FROM clientes;
DELETE FROM empleados;
DELETE FROM productos;



/* damos de alta clientes */

INSERT INTO clientes (id_cliente, nombre, calle, ciudad) VALUES (1, 'JUAN', 'URIA', 'GIJON');
INSERT INTO clientes (id_cliente, nombre, calle, ciudad) VALUES (2, 'MANUEL', 'URIA', 'OVIEDO');
INSERT INTO clientes (id_cliente, nombre, calle, ciudad) VALUES (3, 'LUIS', 'PENALBA', 'MIERES');
INSERT INTO clientes (id_cliente, nombre, calle, ciudad) VALUES (4, 'JOSE', 'LOS ROSALES', 'MIERES');
INSERT INTO clientes (id_cliente, nombre, calle, ciudad) VALUES (5, 'FERNANDO', 'LLANEZA', 'GIJON');
INSERT INTO clientes (id_cliente, nombre, calle, ciudad) VALUES (6, 'JUAN', 'LOS MOROS', 'GIJON');
INSERT INTO clientes (id_cliente, nombre, calle, ciudad) VALUES (7, 'JUAN', 'URIA', 'OVIEDO');
INSERT INTO clientes (id_cliente, nombre, calle, ciudad) VALUES (8, 'PEDRO', 'BARGANIZA', 'AVILES');
INSERT INTO clientes (id_cliente, nombre, calle, ciudad) VALUES (9, 'ELDA', 'LAS CLOTAS', 'GIJON');

/* damos de alta empleados */

INSERT INTO empleados (id_empleado, nombre, calle, ciudad) VALUES (1, 'JUAN', 'URIA', 'GIJON');
INSERT INTO empleados (id_empleado, nombre, calle, ciudad) VALUES (2, 'PEDRO', 'VERSALLES', 'AVILES');
INSERT INTO empleados (id_empleado, nombre, calle, ciudad) VALUES (3, 'MARIA', 'MIERES', 'GIJON');
INSERT INTO empleados (id_empleado, nombre, calle, ciudad) VALUES (4, 'CELIA', 'GARCIA', 'GIJON');
INSERT INTO empleados (id_empleado, nombre, calle, ciudad) VALUES (5, 'FELIPE', 'URIA', 'OVIEDO');
INSERT INTO empleados (id_empleado, nombre, calle, ciudad) VALUES (6, 'NATALIA', 'GIL DE JAZ', 'OVIEDO');
INSERT INTO empleados (id_empleado, nombre, calle, ciudad) VALUES (7, 'VICENTE', 'CERVANTES', 'OVIEDO');
INSERT INTO empleados (id_empleado, nombre, calle, ciudad) VALUES (8, 'JORGE', 'QUEVEDO', 'GIJON');
INSERT INTO empleados (id_empleado, nombre, calle, ciudad) VALUES (9, 'PEDRO', 'MIERES', 'GIJON');

/* damos de alta productos */

INSERT INTO productos  (id_producto, nombre, existencias, precio ) VALUES (1, 'LIMON', 300, 3);
INSERT INTO productos (id_producto, nombre, existencias, precio ) VALUES (2, 'PERA', 500, 3);
INSERT INTO productos (id_producto, nombre, existencias, precio ) VALUES (3, 'PLATANO', 560, 2);
INSERT INTO productos (id_producto, nombre, existencias, precio ) VALUES (4, 'CIRUELA', 400, 4);
INSERT INTO productos (id_producto, nombre, existencias, precio ) VALUES (5, 'NARANJA', 300, 2);
INSERT INTO productos (id_producto, nombre, existencias, precio ) VALUES (6, 'BERENJENA', 300, 3);
INSERT INTO productos (id_producto, nombre, existencias, precio ) VALUES (7, 'CALABACIN', 450, 3);
INSERT INTO productos (id_producto, nombre, existencias, precio ) VALUES (8, 'PEPINO', 400, 3);
INSERT INTO productos (id_producto, nombre, existencias, precio ) VALUES (9, 'GRANADA', 280, 5);
INSERT INTO productos (id_producto, nombre, existencias, precio ) VALUES (10, 'MANZANA', 240, 2);

/* damos de alta pedidos */

INSERT INTO pedidos (id_pedido,id_cliente, id_empleado,  fecha_pedido)  VALUES (1, 1, 1, '01-01-2008');

INSERT INTO pedidos (id_pedido,id_cliente, id_empleado,  fecha_pedido)  VALUES (2, 1, 1, '04-01-2008');
INSERT INTO pedidos (id_pedido,id_cliente, id_empleado,  fecha_pedido)  VALUES (3, 2, 2, '01-01-2008');
INSERT INTO pedidos (id_pedido,id_cliente, id_empleado,  fecha_pedido)  VALUES (4, 4, 1, '03-01-2008');
INSERT INTO pedidos (id_pedido,id_cliente, id_empleado,  fecha_pedido)  VALUES (5, 3, 3, '04-02-2008');
INSERT INTO pedidos (id_pedido,id_cliente, fecha_pedido)                VALUES (6, 4, '01-03-2006');                                 
INSERT INTO pedidos (id_pedido,id_cliente, id_empleado,  fecha_pedido) VALUES (7, 5, NULL, '03-09-2008');   /* este es un pedido sin empleado */
INSERT INTO pedidos (id_pedido,id_cliente, id_empleado,  fecha_pedido) VALUES (8, NULL, 2, '03-09-2008');  /* este es un pedido sin cliente*/
INSERT INTO pedidos (id_pedido,id_cliente, id_empleado,  fecha_pedido) VALUES (9, 5, 2, '03-09-2008');
INSERT INTO pedidos (id_pedido,id_cliente, id_empleado,  fecha_pedido) VALUES (10, 1, 6, '03-09-2010');
INSERT INTO pedidos (id_pedido,id_cliente, id_empleado,  fecha_pedido) VALUES (11, 2, 6, '03-10-2010');
INSERT INTO pedidos (id_pedido,id_cliente, id_empleado,  fecha_pedido)  VALUES (12, 7, 2, '01-01-2008');/* este es un pedido de un cliente de Oviedo para que salgan todos*/
INSERT INTO pedidos (id_pedido, id_empleado,  fecha_pedido)  VALUES (13, 2, '01-01-2008');/* Esto es para que salgan pedidos sin cliente...*/
INSERT INTO pedidos (id_pedido, id_empleado,  fecha_pedido)  VALUES (14, 2, '01-01-2008');/* Esto es para que salgan pedidos sin cliente...*/


/* damos de alta detalles_pedidos  */
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (1, 1, 8);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (1, 2, 10);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (1, 3, 12);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (1, 4, 8);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (1, 5, 10);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (1, 6, 9);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (1, 7, 8);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (1, 8, 10);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (1, 9, 15);

INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (2, 1, 10);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (2, 4, 60);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (3, 1, 10);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (3, 5, 10);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (3, 6, 20);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (4, 1, 50);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (4, 2, 20);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (4, 3, 10);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (5, 1, 15);

INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (6, 1, 9);

INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (10, 1, 20);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (10, 2, 22);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (10, 3, 10);

INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (11, 1, 15);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (11, 2, 17);
/* FOR QUERY Productos en todos los pedidos*/
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (1, 10, 17);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (2, 10, 17);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (3, 10, 17);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (4, 10, 17);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (5, 10, 17);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (6, 10, 17);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (7, 10, 17);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (8, 10, 17);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (9, 10, 17);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (10, 10, 17);
INSERT INTO detalles_pedido (id_pedido,id_producto, cantidad)                 VALUES (11, 10, 17);


