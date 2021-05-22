.mode columns
.headers on
.nullvalue NULL


SELECT avg(baseSalary + extraSalary) AS avgSalary, Specialty 
FROM (
    SELECT healthProfessionalCC AS cc, Specialty 
    FROM Doctor 
    WHERE Specialty NOT NULL
    UNION
    SELECT healthProfessionalCC AS cc, Specialty 
    FROM Nurse 
    WHERE Specialty NOT NULL
    ) 
JOIN HealthProfessional USING (cc) 
GROUP BY Specialty;
