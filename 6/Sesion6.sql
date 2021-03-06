/*
create [or replace] foo (bar)
	returns <type> 
	language plpgsql
	as $$
[declare
	<local_vars>]
begin
	<orders>
end;
$$;
*/

-- Foo 1. Retornar alumno.id dado un nombre.
create function getEstudianteId(nombreEstudiante text) returns int as
$$
declare
	estduanteId int;
begin
	SELECT estudiante_id
	INTO estudianteId
	FROM estudiante
	WHERE estudiante.estudiante_nombre = nombreEstudiante;

	return estudianteId;
end;
$$ language plpgsql;

-- Foo 2. id y nombre de profesores de un departamento concreto.
create function getProfesoresDepartamento(id int)
	returns table (profesor_id int, profesor_nombre varchar(30)) as $$
	begin
		return query SELECT pro.profesor_id, pro.profesor_nombre
		FROM profesor pro
		WHERE pro.departamento_id = id;
	end;
$$ language plpgsql;

-- Excepciones
create or replace function getProfesoresDepartamento(id int)
	returns table (profesor_id int, profesor_nombre varchar(30)) as $$
begin
	return query SELECT pro.profesor_id, pro.profesor_nombre
	FROM profesor pro
	WHERE pro.departamento_id = id;

	if not found
		then raise exception 'No hay ningun departamento %', $1;
	end if;
end;
$$ language plpgsql;

-- Alias
create or replace function getProfesoresDepartamentov3(id int)
returns table (profesor_id int, profesor_nombre varchar(30)) as $$
declare id_aux alias for $1;
	begin
		return query select pro.profesor_id, pro.profesor_nombre from profesor pro
		where pro.departamento_id = id;
		if not found
		then raise exception ?
			 hay ning?n profesor en el departamento %d_aux;
			end if;
		end;
$$ language plpgsql;
			
-- for loop
create function getNumeroDepartamento (id int) returns integer as $$
declare r record; n integer default 0;
begin
	for r in
		select * from profesor pro where pro.departamento_id = id
	loop
		n=n+1;
	end loop;
	return n;
end;
$$ language plpgsql;

/*
procedure
call <procedure>
*/
create procedure getNumeroProfesoresDepartamentov3(id int,
	inout total_profesores int) as $$ --El param total_profesores tiene como perfil inout, por defecto es in.
begin
	select count(*) into total_profesores from profesor pro
	where pro.departamento_id = id;
end;
$$ language plpgsql;

-- main
do $$
declare result int;
begin
	call getNumeroProfesoresDepartamentov4(1, result);
	raise notice 'result = %', result;
end;
$$;

-- while loop
create procedure getProfesoresDepartamento(id int, n int) as $$
declare r record; i integer default 0;
	begin
		while i <> n loop
			i = i + 1;
			select * into r from profesor pro where pro.departamento_id = id and
			pro.profesor_id = i;
			raise notice .or_id, r.profesor_nombre, r.profesor_apellidos;
	end loop;
end;
$$ language plpgsql;

-- array
create procedure getNombreDepartamentos(int []) as $$
declare r record; i integer default 0;
	begin
		foreach i in array $1 loop
			select * into r from departamento dep where dep.departamento_id = i;
			raise notice.departamento_id, r.departamento_nombre;
	end loop;
end;
$$ language plpgsql;


-- 2.1
create function getInfoGrados () 
returns table (grado_nombre varchar(100), numero_estudiantes smallint) as $$
begin
	return query select gra.grado_nombre, gra.numero_estudiantes from grado gra where
	gra.numero_estudiantes= (select min(g2.numero_estudiantes) from grado g2);
end;
$$ language plpgsql;

-- 2.2
create function getAulas()
returns table (aula_nombre varchar(25), cantidad bigint) as $$
begin
	return query
	select au.aula_nombre, count(*)
	from aula au, profesor pro, modulo_profesor_aula mta
	where au.aula_id=mta.aula_id and mta.profesor_id=pro.profesor_id
	group by(au.aula_id)
	having count(pro.profesor_id) >2;
end;
$$ language plpgsql;

-- 2.3
create or replace function getGradoMinEstudiantes()
returns table (grado_nombre varchar(100), cantidad bigint) as $$
begin
	return query
	select gra.grado_nombre, count(*) from grado gra inner join
	estudiante_grado_modulo using(grado_id) inner join modulo mod
	using(modulo_id) group by grado_id having (count(*)) <= all
	(select count(*) from grado gra inner join estudiante_grado_modulo using
	(grado_id) inner join modulo using(modulo_id) group by gra.grado_id);
end;
$$ language plpgsql;

-- 3.1
create procedure getCapacidadTotalAula(inout nAsientos int) as $$
begin
	SELECT SUM(capacidad)
	INTO nAsientos
	FROM aula;
end;
$$ language plpgsql;

-- 3.2
create procedure getEstudiantesIngenieriaIndustrial() as $$
declare r record;
begin
	for r in
	select estudiante_nombre, estudiante_apellidos from estudiante est
	inner join estudiante_grado_modulo egm using(estudiante_id)
	inner join grado gra using(grado_id)
	where lower(gra.grado_nombre)= 'Ingenieria Quimica Industrial'
	union
	select estudiante_nombre, estudiante_apellidos from estudiante est where
	est.erasmus=true
	loop
		raise notice '(%, %)', r.estudiante_nombre, r.estudiante_apellidos;
	end loop;
end;
$$ language plpgsql;

-- 3.3
create or replace procedure getProfesoresComputacionNoAlgoritmia (n int) as $$
declare r record;
begin
	for r in
		(select profesor_nombre, profesor_apellidos from profesor pro
		inner join departamento dep using(departamento_id)
		where dep.departamento_nombre= 'Ciencias de la Computacion'
		except
		select profesor_nombre, profesor_apellidos from profesor pro
		inner join modulo_profesor_aula mpa using(profesor_id)
		inner join modulo mod using(modulo_id)
		where lower(mod.modulo_nombre)='algoritmia')
		LIMIT(n)
	loop
		raise notice '(%, %)', r.profesor_nombre, r.profesor_apellidos;
	end loop;
end;
$$ language plpgsql;