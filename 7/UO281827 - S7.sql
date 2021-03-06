/*
CREATE TRIGGER <nombre> {BEFORE/AFTER} {INSERT/UPDATE/DELETE}
ON <tabla>
[FOR EACH <fila/sentencia>]
[WHEN <cond>]
EXECUTE PROCEDURE <foo (args)>

###################################################################
i.e:
CREATE OR REPLACE FUNCTION modifica_fecha()
RETURNS trigger AS $$
BEGIN
new.fecha = current_date;
return new;
END;
$$ LANGUAGE 'plpgsql’;

CREATE TRIGGER tg_modifica_fecha
BEFORE INSERT ON clientes
FOR EACH ROW
EXECUTE PROCEDURE modifica_fecha();
###################################################################
*/ /*
1 Crear un trigger que cada vez que se inserte una fila en la tabla
‘estudiante_grado_modulo’ se presente el mensaje ‘Se ha realizado una inserción’.
*/ 
create or replace function presenta_insercion() returns trigger as $$
begin
    if tg_op = 'INSERT' then
        raise notice 'Se ha realizado una insercion';
        return new;
    end if;
    return null;
end;
$$ language plpgsql;


create trigger tg_presenta_insercion after
insert on estudiante_grado_modulo
for each row execute procedure presenta_insercion();


insert into estudiante_grado_modulo
values(4,
       1,
       8);

/*
2 trigger presenta_InsertDeleteUpdateOperacion donde cada vez que se actualice
la tabla presente un mensaje
*/
create or replace function presenta_InsertDeleteUpdateOperacion() returns trigger as $$
begin
    if tg_op = 'INSERT' then
        raise notice 'Se ha realizado una insercion';
        return new;
    elsif tg_op = 'DELETE' then
        raise notice 'Se ha realizado un borrado';
        return new;
    elsif tg_op = 'UPDATE' then
        raise notice 'Se ha realizado una actualizacion';
        return new;
    end if;
    return null;
end;
$$ language plpgsql;


create trigger tg_presenta_InsertDeleteUpdateOperacion after
insert
or
delete
or
update on estudiante_grado_modulo
for each row execute procedure presenta_InsertDeleteUpdateOperacion();

-- 3 Incluir en la tabla estudiante_grado_modulo las columnas nota (int) (0) y grado (varchar(10)) ('indefinido')

ALTER TABLE estudiante_grado_modulo ADD COLUMN nota int default 0;


ALTER TABLE estudiante_grado_modulo ADD COLUMN grado varchar(10) default 'indefinido';

-- 4 4 primeras columnas not null

CREATE TABLE operacion_notas_log (operacion char(1) not NULL,
                                                    hora timestamp not null,
                                                                   estudianteId int not null,
                                                                                    moduloId int not null,
                                                                                                 nota int);

-- 5 Crear un trigger que inserte en la tabla del apartado 4 la operacion, hora, e_id, m_id y nota)

create or replace function operacion_log() returns trigger as $$
begin
if tg_op = ‘UPDATE’ then
insert into operacion_notas_log(operacion, hora, estudianteid, moduloid,
nota) values (‘U’, now(), new.estudiante_id, new.modulo_id, new.nota);
return new;
end if;
return null;
end;
$$ language plpgsql;


create trigger tg_operacion_log after
update on estudiante_grado_modulo
for each row execute procedure operacion_log();


update estudiante_grado_modulo
set nota = 5
where estudiante_id=1
    and modulo_id=4;


select *
from operacion_notas_log;


INSERT INTO estudiante_grado_modulo
VALUES (2,
        4,
        7);


UPDATE estudiante_grado_modulo
SET nota=6
WHERE estudiante_id = 2
    AND modulo_id = 4;

-- 6

DROP FUNCTION operacion_log cascade;

-- 7

create or replace function operacion_log() returns trigger as $$
begin
if tg_op = 'UPDATE' then
insert into operacion_notas_log(operacion, hora, estudianteid, moduloid,
nota) values ('U', now(), new.estudiante_id, new.modulo_id, new.nota);
return new;
elsif tg_op = 'INSERT' THEN
insert into operacion_notas_log(operacion, hora, estudianteid, moduloid,
nota) values ('I', now(), new.estudiante_id, new.modulo_id, new.nota);
elsif tg_op = 'DELETE' THEN
insert into operacion_notas_log(operacion, hora, estudianteid, moduloid,
nota) values ('D', now(), old.estudiante_id, old.modulo_id, old.nota);
return old;
end if;
return null;
end;
$$ language plpgsql;


create trigger tg_operacion_log after
update
or
insert
or
delete on estudiante_grado_modulo
for each row execute procedure operacion_log();


INSERT INTO estudiante_grado_modulo
VALUES (1,
        1,
        1);


UPDATE estudiante_grado_modulo
SET nota = 3
WHERE estudiante_id=1
    AND modulo_id=1
    AND grado_id=1;


DELETE
FROM estudiante_grado_modulo
WHERE estudiante_id=1
    AND grado_id=1
    AND modulo_id=1;

-- 8

DROP TABLE operacion_notas_log;


DROP TRIGGER tg_operacion_log ON estudiante_grado_modulo;

-- 9

CREATE TABLE operacion_calificacion_log(operacion char(1) not NULL,
                                                          hora timestamp not null,
                                                                         estudianteId int not null,
                                                                                          moduloId int not null,
                                                                                                       nota int, calificacion varchar(10));

-- 10

create or replace function calificacion_log() returns trigger as $$
declare
    calif varchar(10);
begin
-- calif
if new.nota < 4 THEN
    calif = 'Pobre';
elsif new.nota < 5 THEN
    calif = 'No buena';
elsif new.nota < 7 THEN
    calif = 'Buena';
elsif new.nota < 9 THEN
    calif = 'Muy buena';
else
    calif = 'Excelente';
end if;

-- insert
if tg_op = 'UPDATE' then
insert into operacion_calificacion_log values ('U', now(), new.estudiante_id, new.modulo_id, new.nota, calif);
return new;
elsif tg_op = 'INSERT' THEN
insert into operacion_calificacion_log values ('I', now(), new.estudiante_id, new.modulo_id, new.nota, calif);
elsif tg_op = 'DELETE' THEN
insert into operacion_calificacion_log values ('D', now(), old.estudiante_id, old.modulo_id, old.nota, calif);
return old;
end if;
return null;
end;
$$ language plpgsql;


create trigger tg_calificacion_log after
update
or
insert
or
delete on estudiante_grado_modulo
for each row execute procedure calificacion_log();

