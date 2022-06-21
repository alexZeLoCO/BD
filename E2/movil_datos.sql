\c movil


insert into movil values(1, 'Apple');
insert into movil values(2, 'Fairphone');
insert into movil values(3, 'Samsung');
insert into movil values(4, 'Xiaomi');
insert into movil values(5, 'Oppo');


insert into componente values(100, 'Electronica');
insert into componente values(101, 'Caja');
insert into componente values(102, 'Bateria');
insert into componente values(103, 'Microfono');
insert into componente values(104, 'Tarjeta MicroSD');
insert into componente values(105, 'Plegable');


insert into movilcomponente values(1, 100);
insert into movilcomponente values(1, 101);
insert into movilcomponente values(1, 102);
insert into movilcomponente values(1, 103);
insert into movilcomponente values(2, 100);
insert into movilcomponente values(2, 101);
insert into movilcomponente values(2, 102);
insert into movilcomponente values(2, 103);
insert into movilcomponente values(2, 104);
insert into movilcomponente values(3, 100);
insert into movilcomponente values(3, 101);
insert into movilcomponente values(3, 102);
insert into movilcomponente values(3, 103);
insert into movilcomponente values(4, 100);
insert into movilcomponente values(4, 101);
insert into movilcomponente values(4, 102);
insert into movilcomponente values(4, 103);
insert into movilcomponente values(5, 100);
insert into movilcomponente values(5, 101);
insert into movilcomponente values(5, 102);
insert into movilcomponente values(5, 103);
insert into movilcomponente values(5, 104);
insert into movilcomponente values(5, 105);


insert into material values(200, 'niquel');
insert into material values(201, 'coltan');
insert into material values(202, 'litio');
insert into material values(203, 'magnesio');
insert into material values(204, 'neodinio');
insert into material values(205, 'disprosio');
insert into material values(206, 'galio');


insert into componenteMaterial values (100, 200);
insert into componenteMaterial values(100, 206);
insert into componenteMaterial values(101, 200);
insert into componenteMaterial values(101, 203);
insert into componenteMaterial values(102, 202);
insert into componenteMaterial values(102, 200);
insert into componenteMaterial values(102, 201);
insert into componenteMaterial values (103, 200);
insert into componenteMaterial values (103, 204);
insert into componenteMaterial values (103, 205);
insert into componenteMaterial values (103, 206);


insert into origen values(301, 'Congo');
insert into origen values(302, 'Australia');
insert into origen values(303, 'Brasil');
insert into origen values(304, 'Tailandia');
insert into origen values(305, 'Rusia');
insert into origen values(306, 'Canada');
insert into origen values(307, 'Argentina');
insert into origen values(308, 'Chile');

insert into materialOrigen values (200, 306);
insert into materialOrigen values (200, 305);
insert into materialOrigen values (201, 301);
insert into materialOrigen values (201, 302);
insert into materialOrigen values (201, 303);
insert into materialOrigen values (201, 304);
insert into materialOrigen values (202, 307);
insert into materialOrigen values (202, 308);




