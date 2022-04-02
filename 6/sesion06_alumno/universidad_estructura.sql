\c template1
drop database universidad;
create database universidad;
\c universidad

create table if not exists grado(
	grado_id int primary key not null,
	grado_nombre varchar(100) unique not null,
        numero_estudiantes smallint
);

create table if not exists modulo(
	modulo_id int primary key not null,
	modulo_nombre varchar(100) unique not null,
	curso smallint
);

create table if not exists departamento(
	departamento_id int primary key not null,
	departamento_nombre varchar(40) not null
);

create table if not exists profesor(
	profesor_id int primary key not null,
	departamento_id int not null,
	profesor_nombre varchar(25) not null,
	profesor_apellidos varchar(25) not null,
	foreign key (departamento_id) references departamento(departamento_id)
);

create table if not exists aula(
	aula_id int primary key not null,
	aula_nombre varchar(25) not null,
        capacidad int not null
);

create table if not exists estudiante(
	estudiante_id int primary key not null,
	estudiante_nombre varchar(30) not null,
	estudiante_apellidos varchar(30) not null, 
        erasmus boolean
);

create table if not exists estudiante_grado_modulo(
	estudiante_id int not null,
	grado_id int not null,
	modulo_id int not null,
	primary key(estudiante_id, modulo_id),
	foreign key (estudiante_id) references estudiante(estudiante_id),
	foreign key (grado_id) references grado(grado_id),
	foreign key (modulo_id) references modulo(modulo_id)
);

create table if not exists grado_modulo(
	grado_id int not null,
	modulo_id int not null,
	primary key(grado_id, modulo_id),
	foreign key (grado_id) references grado(grado_id),
	foreign key (modulo_id) references modulo(modulo_id)
);

create table if not exists modulo_profesor_aula(
	modulo_id int not null,	
	profesor_id int not null,
	aula_id int not null,
	primary key(modulo_id, profesor_id, aula_id),
	foreign key (aula_id) references aula(aula_id),
	foreign key (modulo_id) references modulo(modulo_id),
	foreign key (profesor_id) references profesor(profesor_id)
);











