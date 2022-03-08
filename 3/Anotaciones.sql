-- Variante Consulta 2
SELECT DISTINCT(disco), COUNT(pcid) AS cantidad
FROM pc
GROUP BY disco
HAVING COUNT(pcid) > 1; -- En COUNT() utilizar siempre COUNT(<primary_key>)

-- Variante Consulta 3
SELECT AVG(precio)
FROM pc
GROUP BY tgrafica
HAVING tgrafica = 'ati001';