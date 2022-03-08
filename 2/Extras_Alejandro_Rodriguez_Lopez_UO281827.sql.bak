/* Cosulta 1: Sin unión */
SELECT pcid, cpu_tipo mem_tipo, precio
FROM pc
LEFT JOIN cpu ON cpu.cpu_id = pc.cpu
LEFT JOIN memoria ON memoria.mem_id = pc.memoria
LEFT JOIN disco ON disco.disco_id = pc.disco
WHERE cpu.cpu_tipo = 'Core2 duo'
AND pc.precio < 1050
OR disco.disco_capacidad < 400;

/* Consulta 2: Con unión */
SELECT pcid, cpu_tipo mem_tipo, precio
FROM pc
LEFT JOIN cpu ON cpu.cpu_id = pc.cpu
LEFT JOIN memoria ON memoria.mem_id = pc.memoria
LEFT JOIN disco ON disco.disco_id = pc.disco
WHERE cpu.cpu_tipo = 'Core2 duo'
AND pc.precio < 1050
UNION
SELECT pcid, cpu_tipo mem_tipo, precio
FROM pc
LEFT JOIN cpu ON cpu.cpu_id = pc.cpu
LEFT JOIN memoria ON memoria.mem_id = pc.memoria
LEFT JOIN disco ON disco.disco_id = pc.disco
WHERE disco.disco_capacidad < 400;

/* Consulta 2: Sin Except */
SELECT pcid, mem_tipo, mem_capacidad, cpu_fabricante, cpu_tipo, disco_fabricante, disco_capacidad, tgraf_fabricante, precio
FROM pc
INNER JOIN cpu ON cpu.cpu_id = pc.cpu
LEFT JOIN memoria ON memoria.mem_id = pc.memoria
INNER JOIN disco ON disco.disco_id = pc.disco
INNER JOIN tgrafica ON tgrafica.tgraf_id = pc.tgrafica
WHERE memoria.mem_tipo = 'DDR3 SDRAM'
OR pc.memoria IS NULL
ORDER BY pc.precio;

/* Consulta 2: Con Except */
SELECT pcid, mem_tipo, mem_capacidad, cpu_fabricante, cpu_tipo, disco_fabricante, disco_capacidad, tgraf_fabricante, precio
FROM pc
INNER JOIN cpu ON cpu.cpu_id = pc.cpu
LEFT JOIN memoria ON memoria.mem_id = pc.memoria
INNER JOIN disco ON disco.disco_id = pc.disco
INNER JOIN tgrafica ON tgrafica.tgraf_id = pc.tgrafica
EXCEPT
SELECT pcid, mem_tipo, mem_capacidad, cpu_fabricante, cpu_tipo, disco_fabricante, disco_capacidad, tgraf_fabricante, precio
FROM pc
LEFT JOIN cpu ON cpu.cpu_id = pc.cpu
INNER JOIN memoria ON memoria.mem_id = pc.memoria
LEFT JOIN disco ON disco.disco_id = pc.disco
LEFT JOIN tgrafica ON tgrafica.tgraf_id = pc.tgrafica
WHERE pc.memoria IS NOT NULL
AND memoria.mem_tipo != 'DDR3 SDRAM'
ORDER BY precio;