/* 
BD BibliotecaExamen

Ejecutar CMD desde la carpeta donde tengamos el script, conectarse a psql y ejecutar:
\i biblio_esquema.sql  

*/


\c template1
DROP DATABASE IF EXISTS biblioexamen;
CREATE DATABASE biblioexamen;
\c biblioexamen
 

CREATE TABLE autor(
id_autor INTEGER PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
pais VARCHAR(50), 
fecha_nacimiento DATE 
);

CREATE TABLE libro(
id_libro INTEGER PRIMARY KEY,
titulo VARCHAR(50) NOT NULL,
area VARCHAR(50) NOT NULL,
id_autor INTEGER NOT NULL,
FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
);

CREATE TABLE alumno(
id_alumno INTEGER PRIMARY KEY,
dni VARCHAR(9) UNIQUE,
nombre VARCHAR(20) NOT NULL,
ciudad VARCHAR(20) NOT NULL,
fecha_nacimiento DATE NOT NULL
);

CREATE TABLE prestamo(
id_alumno INTEGER NOT NULL,
id_libro INTEGER NOT NULL,
dias_restantes INTEGER NOT NULL,
PRIMARY KEY (id_alumno, id_libro),
FOREIGN KEY (id_alumno) REFERENCES alumno(id_alumno),
FOREIGN KEY (id_libro) REFERENCES libro(id_libro)
);
