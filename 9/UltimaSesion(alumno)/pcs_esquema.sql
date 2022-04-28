/*Author: Maria Teresa Gonzalez-Aparicio
Universidad de Oviedo, Gijon 2021,
Ultima sesion */

create database pcs;
\c pcs;
/* Tabla - fabricante*/
create table if not exists fabricante (
id_fabricante int not null primary key,
nombre varchar(100),
direccion varchar(100) not null, 
telefono varchar(15) not null);

/* Tabla - Tipo de memoria*/
create table if not exists tipo_memoria (
id_tipo_memoria int not null primary key, 
descripcion varchar(100));

/* Tabla - Tipo de cpu */
create table if not exists tipo_cpu(
id_tipo_cpu int not null primary key, 
descripcion varchar(100), 
tipo int not null);

/* Tabla - memoria */
create table if not exists memoria (
id_memoria int not null primary key,
capacidad varchar(30) not null,
transferencia_datos varchar(30) not null,
precio decimal(10, 2),
id_fabricante int not null, 
id_tipo_memoria int not null, 
foreign key (id_fabricante) references fabricante (id_fabricante),
foreign key (id_tipo_memoria) references tipo_memoria(id_tipo_memoria));

/* Tabla - Tarjeta grafica */
create table if not exists tarjeta_grafica (
id_tarjeta_grafica int not null primary key,
descripcion varchar(100),
precio decimal(10,2),
id_fabricante int not null,
id_tipo_memoria int not null,
foreign key (id_fabricante) references fabricante (id_fabricante),
foreign key (id_tipo_memoria) references tipo_memoria (id_tipo_memoria));

/* Tabla - disco */
create table if not exists disco(
id_disco int not null primary key,
descripcion varchar(100),
capacidad varchar(30) not null,
precio decimal(10,2),
id_fabricante int not null,
foreign key (id_fabricante) references fabricante (id_fabricante));

/* Tabla - cpu */
create table if not exists cpu (
id_cpu int not null primary key,
descripcion varchar(100),
precio decimal(10,2),
id_fabricante int not null,
id_tipo_cpu int not null,
foreign key (id_fabricante) references fabricante (id_fabricante),
foreign key (id_tipo_cpu) references tipo_cpu (id_tipo_cpu));


create table if not exists pc (
id_pc int not null primary key,
id_cpu int not null,
id_disco int not null,
id_memoria int not null,
id_tarjeta_grafica int not null,
foreign key (id_cpu) references cpu (id_cpu),
foreign key (id_disco) references disco (id_disco),
foreign key (id_memoria) references memoria (id_memoria),
foreign key (id_tarjeta_grafica) references tarjeta_grafica (id_tarjeta_grafica));

create table if not exists proveedor (
id_proveedor int not null primary key,
nombre varchar(100) not null,
pais varchar(50) not null
);

create table if not exists proveedor_memoria (
id_proveedor int not null,
id_memoria int not null,
primary key (id_proveedor, id_memoria),
foreign key (id_proveedor) references proveedor (id_proveedor),
foreign key (id_memoria) references memoria(id_memoria));

