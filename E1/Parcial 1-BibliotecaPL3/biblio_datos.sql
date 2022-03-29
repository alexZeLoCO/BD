/* 
BD BibliotecaExamen

Ejecutar CMD desde la carpeta donde tengamos el script, conectarse a psql y ejecutar:
\i biblio_datos.sql 

*/

\c biblioexamen

DELETE FROM prestamo;
DELETE FROM alumno;
DELETE FROM libro;
DELETE FROM autor;

 /* Autor */
INSERT INTO autor VALUES (1,'Juan Rufol',NULL, NULL);
INSERT INTO autor VALUES (2,'Willian Golding','Alemania','1978/01/19');
INSERT INTO autor VALUES (3,'Barbara Gostmich','Francia','1977/08/21');
INSERT INTO autor VALUES (4,'Mario Benedetti','USA','1977/05/19');
INSERT INTO autor VALUES (5,'Alfredo Gutierrez','Espania','1971/04/29');
INSERT INTO autor VALUES (6,'Jose Gonzalez','Italia','1980/02/01');
INSERT INTO autor VALUES (7,'Ana Moreno','Espania','1977/01/02');
INSERT INTO autor VALUES (8,'Kimi Alfred','USA','1980/03/14');
INSERT INTO autor VALUES (9,'Thomas Huxley',NULL, NULL);
INSERT INTO autor VALUES (10,'Leticia Lopez Juarez','Alemania','1973/05/05');
INSERT INTO autor VALUES (11,'Osar Palacios Ceballos','Espania','1976/02/25');
INSERT INTO autor VALUES (12,'Sofia Heredia','Portugal','1980/10/31');

 
 /* Alumno */
INSERT INTO alumno VALUES (1, '11111419S', 'Alberto Vega', 'Gijon', '1992/08/08');
INSERT INTO alumno VALUES (2, '11111806M', 'Luisa Perez', 'Gijon', '1991/03/28');
INSERT INTO alumno VALUES (3, '11111885A', 'Antonio Martinez', 'Gijon', '2000/10/05');
INSERT INTO alumno VALUES (4, '22222867Y', 'Jose Garcia', 'Gijon', '1998/01/28');
INSERT INTO alumno VALUES (5, '22222167K', 'Ismael Casas', 'Oviedo', '1999/05/24');
INSERT INTO alumno VALUES (6, '33342551K', 'Ramon Simarro', 'Mieres', '1996/11/21');
INSERT INTO alumno VALUES (7, '55500325E', 'Ernesto Rubio', 'Mieres', '1997/04/26');
INSERT INTO alumno VALUES (8, '66678526G', 'Maria Lopez', 'Oviedo', '1998/09/01');
INSERT INTO alumno VALUES (9, '77757732Y', 'Alberto Lopez', 'Oviedo', '1998/01/01');
INSERT INTO alumno VALUES (10, '88891230N', 'Antonio Guerrero', 'Oviedo', '1999/02/11');
INSERT INTO alumno VALUES (11, '99953235G', 'Irene Martinez', 'Gijon', '1996/03/12');
INSERT INTO alumno VALUES (12, '82315620V', 'Manuel Ruiz', 'Oviedo', '1995/04/13');


/* Libro */
INSERT INTO libro VALUES (1,'El silencio','Novela',1);
INSERT INTO libro VALUES (2,'El esclavo','Narracion',1);
INSERT INTO libro VALUES (3,'El hobbit','Aventura',2);
INSERT INTO libro VALUES (4,'Como la vida misma','Narracion',3);
INSERT INTO libro VALUES (5,'Visual Studio Tercera Edicion','Informatica',4);
INSERT INTO libro VALUES (6,'Base de Datos','Informatica',4);
INSERT INTO libro VALUES (7,'Ingenieria de Software','Informatica',4);
INSERT INTO libro VALUES (8,'La isla perdida','Novela',5);
INSERT INTO libro VALUES (9,'Entregame tu corazon','Novela',6);
INSERT INTO libro VALUES (10,'Tutorial avanzado de C++','Internet',7);
INSERT INTO libro VALUES (11,'Tutorial SQL','Internet',7);
INSERT INTO libro VALUES (12,'Orgullo y prejuicio','Novela',8);
INSERT INTO libro VALUES (13,'Romeo y Manolita','Novela',9);
INSERT INTO libro VALUES (14,'Vuelta al mundo','Aventura',10);
INSERT INTO libro VALUES (15,'Entre las tinieblas','Aventura', 10);

/* Prestamo */
INSERT INTO prestamo VALUES(1,1,5);
INSERT INTO prestamo VALUES(2,3,6);
INSERT INTO prestamo VALUES(2,14,7);
INSERT INTO prestamo VALUES(2,15,3);
INSERT INTO prestamo VALUES(3,2,1);
INSERT INTO prestamo VALUES(3,7,2);
INSERT INTO prestamo VALUES(4,10,5);
INSERT INTO prestamo VALUES(4,11,6);
INSERT INTO prestamo VALUES(5,15,7);
INSERT INTO prestamo VALUES(5,7,4);
INSERT INTO prestamo VALUES(5,10,3);
INSERT INTO prestamo VALUES(6,11,5);
INSERT INTO prestamo VALUES(6,14,2);
INSERT INTO prestamo VALUES(6,15,2);
INSERT INTO prestamo VALUES(7,14,1);
INSERT INTO prestamo VALUES(8,4,1);
INSERT INTO prestamo VALUES(8,14,3);
INSERT INTO prestamo VALUES(9,3,5);
INSERT INTO prestamo VALUES(9,14,6);
INSERT INTO prestamo VALUES(9,15,6);
INSERT INTO prestamo VALUES(10,10,4);
INSERT INTO prestamo VALUES(10,11,4);
INSERT INTO prestamo VALUES(11,2,2);
INSERT INTO prestamo VALUES(11,4,7);
INSERT INTO prestamo VALUES(11,8,7);
































