/*Author: Maria Teresa Gonzalez-Aparicio
Universidad de Oviedo, Gijon 2021,
Ultima sesion */

\c pcs;

/* Fabricante */
insert into fabricante values (100,'Kingston','17600 Newhope Street, Fountain Valley', '+1(714)435-2600');
insert into fabricante values (101, 'Digi-key', '701 Brooks Avenue South, USA', '(+34) 960029708');
insert into fabricante values (102, 'Intel', '2200 Mission College Blvd, Santa Clara', '(408)765-8080');
insert into fabricante values (103, 'AMD', '2485 Augustine Drive, Santa Clara, CA', '+1408-749-4000');
insert into fabricante values (104, 'Tesla', '8300 E Raintree Drive, Scottsdale, CA', '(4800) 361-0036');

/* Tipo de memoria */
insert into tipo_memoria values (200, '64GB Modulo - DDR4 2666MHz');
insert into tipo_memoria values (201, '32GB Modulo - DDR4 2400MHz');
insert into tipo_memoria values (202, '16GB Modulo - DDR4 2400MHz');
insert into tipo_memoria values (203, '4GB');
insert into tipo_memoria values(204, '2GB');
insert into tipo_memoria values (205, '11GB');

/* Memoria */
insert into memoria values (300, '64GB', 'PC4-2666', 48, 100, 200);
insert into memoria values (301, '32GB', 'PC4-2400', 209, 100, 201);
insert into memoria values (302, '16GB', 'PC4-2400', 108, 100, 202);
insert into memoria values (303, '32GB', '3.2GT/s', 211, 101, 202);
insert into memoria values (304, '64GB', '2.9GT/s', 408, 101, 200);

/* Tipo de cpu */
insert into tipo_cpu values(400, 'dual core', 2);
insert into tipo_cpu values(401, 'quad core', 4);
insert into tipo_cpu values(402, 'seis core', 6);
insert into tipo_cpu values(403, 'ocho core', 8);


/* CPU */
insert into cpu values (500, 'dual core, dos procesadores', 118, 102, 400);
insert into cpu values (501, 'dual core, un procesador', 30, 103, 400);
insert into cpu values (502, 'quod core, oun procesador', 14, 102, 401);
insert into cpu values (503, 'quod core', 8, 103, 401);

/* Disco */
insert into disco values(600, 'SSDNOW A2000', '500GB', 70, 100);
insert into disco values(601, 'SSD A400', '120Gb', 23, 100);
insert into disco values(602, 'SSD SATA III Flash', '120GB', 140, 101);
insert into disco values(603, 'SSD Pro 5450S', '256GB', 88, 102);
insert into disco values (604, 'SSD 660P', '2TB', 268, 102);


/* Tarjeta grafica */
insert into tarjeta_grafica values (700, 'Asus GeForce GTX 1050 Ti', 418, 103, 203);
insert into tarjeta_grafica values (701, 'MSI GeForce GT710', 48, 103, 204);
insert into tarjeta_grafica values (702, 'Gigabyte AORUS GeForce RTX 2080 Ti Xtreme', 545, 103, 205);


/* PC's */
insert into pc values (1, 500, 602, 302, 700);
insert into pc values (2, 500, 602, 302, 701);
insert into pc values (3, 501, 600, 300, 702);
insert into pc values (4, 503, 604, 301, 700);
insert into pc values (5, 502, 603, 303, 702);
insert into pc values (6, 500, 601, 304, 701);
insert into pc values (7, 501, 603, 304, 700);

/* proveedor */
insert into proveedor values (800,'Alfresco','Alemania');
insert into proveedor values (801, 'Galiana', 'Francia');
insert into proveedor values (802, 'Romanesco', 'Italia');

/* proveedor memoria*/
insert into proveedor_memoria values (800,300);
insert into proveedor_memoria values (800,301);
insert into proveedor_memoria values (801,300);
insert into proveedor_memoria values (801,303);
insert into proveedor_memoria values (802,300);
insert into proveedor_memoria values (802,301);
insert into proveedor_memoria values (802,302);
insert into proveedor_memoria values (802,303);
insert into proveedor_memoria values (802,304);




