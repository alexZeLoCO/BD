create table clientes (
	id_cliente integer not null Primary key, 
	nombre varchar(20) not null, 
	calle varchar(20),
	ciudad varchar(20)
	);


create table empleados (
	id_empleado integer not null primary key,
	nombre varchar(20) not null, 
	calle varchar(20),
	ciudad varchar(20)
	);


create table productos ( 
	id_producto integer not null primary key,
	nombre varchar(20) not null, 
	existencias integer,
	precio integer not null
	);

create table pedidos (
	id_pedido integer not null primary key,
	id_cliente integer,  -- se admiten valores nulos (puede haber pedidos sin cliente)
	id_empleado integer ,
	fecha_pedido date not null,
	foreign key (id_cliente) references clientes (id_cliente),
	foreign key (id_empleado) references empleados (id_empleado)
	);

create table detalles_pedido (
	id_pedido integer not null,
	id_producto integer not null,
	cantidad integer not null,
	primary key (id_pedido,id_producto),
	foreign key (id_pedido) references pedidos(id_pedido),
	foreign key (id_producto) references productos(id_producto)
	);
