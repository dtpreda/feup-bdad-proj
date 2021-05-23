.mode columns
.headers on
.nullvalue NULL

-- What is the most frequent type of Occurrence per Specialty of
-- HealthProfessional and how much frequent it was?


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
