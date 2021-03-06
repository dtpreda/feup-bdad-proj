.mode columns
.headers on
.nullvalue NULL

-- Which people with the same condition are taking the same medication?

SELECT DISTINCT patient1 AS patient, condition1 AS condition, drugName1 AS medicationName
FROM (
    SELECT * FROM
        (SELECT name AS patient1, condition AS condition1, drugName1 
        FROM Person JOIN (
            SELECT patientCC AS cc, condition, name AS drugName1
            FROM Medication) 
        USING (cc))
    JOIN 
        (SELECT name AS patient2, drugName2, condition2 
        FROM Person JOIN (
            SELECT patientCC AS cc, condition AS condition2, name AS drugName2
            FROM Medication) 
        USING (cc))
    WHERE patient1 <> patient2 AND condition1 == condition2 AND drugName1 == drugName2
) ORDER BY (drugName1);
