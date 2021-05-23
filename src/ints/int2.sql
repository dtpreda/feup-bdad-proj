.mode columns
.headers on
.nullvalue NULL

-- What is the average salary per health professional specialty?

SELECT Specialty,  avg(baseSalary + extraSalary) AS avgSalary
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
GROUP BY Specialty
ORDER BY avgSalary DESC, Specialty ASC;
