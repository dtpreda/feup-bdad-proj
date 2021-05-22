.mode columns
.headers on
.nullvalue NULL


SELECT DISTINCT patient1 AS patient, condition1 AS condition, drugName1 AS drugName
FROM (
    SELECT * FROM
        (SELECT name AS patient1, condition AS condition1, drugName AS drugName1 
        FROM Person JOIN (
            SELECT patientCC AS cc, condition, drugName 
            FROM Prescription) 
        USING (cc))
    JOIN 
        (SELECT name AS patient2, drugName2, condition2 
        FROM Person JOIN (
            SELECT patientCC AS cc, condition AS condition2, drugName AS drugName2
            FROM Prescription) 
        USING (cc))
    WHERE patient1 <> patient2 AND condition1 == condition2 AND drugName1 == drugName2
) ORDER BY (drugName);
