\c template1
drop database movil;
create database movil;
\c movil

create table movil (
	id integer unique primary key,
	nombre varchar(20)
);

create table componente(
    id integer unique primary key,
    nombre varchar(20)
);

create table movilcomponente(
    id_movil integer,
	id_componente integer,
	primary key(id_movil, id_componente),
	foreign key (id_movil) references movil(id),
	foreign key (id_componente) references componente(id)
);

create table material(
    id integer unique primary key,
	nombre varchar(20)
);

create table componentematerial(
    id_componente integer,
	id_material integer,
	primary key(id_componente, id_material),
	foreign key (id_componente) references componente(id),
	foreign key (id_material) references material(id)
);

create table origen(
    id integer unique primary key,
	lugar varchar(20)
);

create table materialorigen(
	id_material integer,
	id_origen integer,
	primary key(id_material, id_origen),
	foreign key (id_material) references material(id),
	foreign key (id_origen) references origen(id)
);