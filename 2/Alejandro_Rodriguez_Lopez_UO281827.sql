CREATE TABLE cpu (cpu_id VARCHAR(20) UNIQUE NOT NULL PRIMARY KEY,
	cpu_fabricante VARCHAR(20),
	cpu_tipo VARCHAR(20)
	);

CREATE TABLE memoria (mem_id VARCHAR(20) UNIQUE NOT NULL PRIMARY KEY,
	mem_capacidad INTEGER,
	mem_tipo VARCHAR(20)
	);
	
CREATE TABLE disco (disco_id VARCHAR(20) UNIQUE NOT NULL PRIMARY KEY,
	disco_fabricante VARCHAR(20),
	disco_capacidad INTEGER
	);

CREATE TABLE tgrafica (tgraf_id VARCHAR(20) UNIQUE NOT NULL PRIMARY KEY,
	tgraf_fabricante VARCHAR(20)
	);
	
CREATE TABLE pc (pcid INTEGER UNIQUE NOT NULL PRIMARY KEY,
	memoria VARCHAR(20),
	cpu VARCHAR (20),
	tgrafica VARCHAR (20),
	disco VARCHAR (20) REFERENCES disco(disco_id),
	precio INTEGER,
	FOREIGN KEY (memoria) REFERENCES memoria(mem_id),
	FOREIGN KEY (cpu) REFERENCES cpu(cpu_id),
	FOREIGN KEY (tgrafica) REFERENCES tgrafica(tgraf_id)
	);

INSERT INTO cpu VALUES ('cpu0001', 'intel', 'Core2 duo');
INSERT INTO cpu VALUES ('cpu0002', 'intel', 'Core2 Quad');
INSERT INTO cpu VALUES ('cpu0003', 'amd', 'Athlon X2');

INSERT INTO memoria VALUES ('mem0001', 1024, 'DDR SDRAM');
INSERT INTO memoria VALUES ('mem0002', 1024, 'DDR2 SDRAM');
INSERT INTO memoria VALUES ('mem0003', 1024, 'DDR3 SDRAM');
INSERT INTO memoria VALUES ('mem0004', 2048, 'DDR3 SDRAM');

INSERT INTO disco VALUES ('disco0001', 'seagate', 350);
INSERT INTO disco VALUES ('disco0002', 'seagate', 500);
INSERT INTO disco VALUES ('disco0003', 'seagate', 1024);
INSERT INTO disco VALUES ('disco0004', 'samsung', 500);

INSERT INTO tgrafica VALUES ('ati001', 'ati');
INSERT INTO tgrafica VALUES ('nvidia001', 'nvidia');

INSERT INTO pc VALUES (1, 'mem0001', 'cpu0001', 'ati001'   , 'disco0001', 1000);
INSERT INTO pc VALUES (2, 'mem0001', 'cpu0001', 'ati001'   , 'disco0002', 1100);
INSERT INTO pc VALUES (3, 'mem0002', 'cpu0002', 'nvidia001', 'disco0003', 1400);
INSERT INTO pc VALUES (4, 'mem0004', 'cpu0003', 'nvidia001', 'disco0004', 1600);
INSERT INTO pc (pcid, cpu, disco, tgrafica, precio)
	VALUES (5, 'cpu0001', 'disco0001', 'ati001', 900);
INSERT INTO pc (pcid, tgrafica, precio)
	VALUES (6, 'ati001', 400);

/* Consulta 1 */
SELECT 	pcid AS pc_ID,
		mem_tipo AS RAM,
		mem_capacidad AS RAM_MB,
		cpu_fabricante AS CPU,
		cpu_tipo AS CPU_Tipo,
		disco_fabricante AS Disco,
		disco_capacidad AS Disco_GB,
		tgraf_fabricante AS GPU,
		precio
FROM pc 
INNER JOIN memoria ON pc.memoria = memoria.mem_id
INNER JOIN cpu ON pc.cpu = cpu.cpu_id
INNER JOIN disco ON pc.disco = disco.disco_id
INNER JOIN tgrafica ON pc.tgrafica = tgrafica.tgraf_id
ORDER BY precio DESC;

/* Consulta 2 */
SELECT 	pcid AS pc_ID,
		mem_tipo AS RAM,
		mem_capacidad AS RAM_MB,
		cpu_fabricante AS CPU,
		cpu_tipo AS CPU_Tipo,
		disco_fabricante AS Disco,
		disco_capacidad AS Disco_GB,
		tgraf_fabricante AS GPU,
		precio
FROM pc 
LEFT JOIN memoria ON pc.memoria = memoria.mem_id
LEFT JOIN cpu ON pc.cpu = cpu.cpu_id
LEFT JOIN disco ON pc.disco = disco.disco_id
LEFT JOIN tgrafica ON pc.tgrafica = tgrafica.tgraf_id
ORDER BY precio DESC;

/* Consulta 3 */
SELECT 	pcid AS pc_ID,
		mem_tipo AS RAM,
		mem_capacidad AS RAM_MB,
		cpu_fabricante AS CPU,
		cpu_tipo AS CPU_Tipo,
		disco_fabricante AS Disco,
		disco_capacidad AS Disco_GB,
		tgraf_fabricante AS GPU,
		precio
FROM pc 
LEFT JOIN memoria ON pc.memoria = memoria.mem_id
LEFT JOIN cpu ON pc.cpu = cpu.cpu_id
LEFT JOIN disco ON pc.disco = disco.disco_id
LEFT JOIN tgrafica ON pc.tgrafica = tgrafica.tgraf_id
EXCEPT
SELECT 	pcid AS pc_ID,
		mem_tipo AS RAM,
		mem_capacidad AS RAM_MB,
		cpu_fabricante AS CPU,
		cpu_tipo AS CPU_Tipo,
		disco_fabricante AS Disco,
		disco_capacidad AS Disco_GB,
		tgraf_fabricante AS GPU,
		precio
FROM pc 
INNER JOIN memoria ON pc.memoria = memoria.mem_id
INNER JOIN cpu ON pc.cpu = cpu.cpu_id
INNER JOIN disco ON pc.disco = disco.disco_id
INNER JOIN tgrafica ON pc.tgrafica = tgrafica.tgraf_id
ORDER BY precio DESC;