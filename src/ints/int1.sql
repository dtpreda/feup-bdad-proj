.mode columns
.headers on
.nullvalue NULL

-- What is the number of occurrences per region?

SELECT region, COUNT(*) AS numberOfOccurences
FROM Hospital JOIN Ocurrence ON (Hospital.name=Ocurrence.hospital)
GROUP BY region
ORDER BY numberOfOccurences DESC;
