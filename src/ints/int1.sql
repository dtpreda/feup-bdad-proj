.mode columns
.headers on
.nullvalue NULL

-- Número de ocorrencias por região.

SELECT region, COUNT(*) AS numberOfOccurences
FROM Hospital JOIN Ocurrence ON (Hospital.name=Ocurrence.hospital)
GROUP BY region;
