.mode columns
.headers on
.nullvalue NULL

-- Tipo de ocorrencia mais frequente por especialidade de HP.

--TODO detetar empates?

SELECT specialty, type, MAX(total) AS total
FROM (
    SELECT COUNT(*) AS total, specialty, type
    FROM (
        SELECT specialty, type
        FROM Ocurrence 
        JOIN Participated ON(Ocurrence.id=Participated.ocurrence)
        JOIN (
            SELECT healthProfessionalCC AS healthProfessional, specialty 
            FROM Doctor 
            WHERE specialty NOT NULL
            UNION
            SELECT healthProfessionalCC AS healthProfessional, specialty 
            FROM Nurse 
            WHERE specialty NOT NULL
        ) USING(healthProfessional)
    ) GROUP BY specialty, type
) GROUP BY specialty;
