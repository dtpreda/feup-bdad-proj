.mode columns
.headers on
.nullvalue NULL

-- What is the frequency of the different Occurrence gravity types per age group?

DROP VIEW IF EXISTS AgeGravity;

CREATE VIEW AgeGravity AS
SELECT (JulianDay("now")-JulianDay(birthDate))/365.25 AS age, gravity
FROM Ocurrence JOIN Patient ON(Ocurrence.patient=Patient.cc) JOIN Person USING(cc);

SELECT *
FROM (
        SELECT "[0, 10[" AS ageGroup, gravity, COUNT(*) AS numberOfOccurences
        FROM (
            SELECT *
            FROM AgeGravity
            WHERE age < 10
        ) GROUP BY gravity
    UNION 
        SELECT "[10,20[" AS ageGroup, gravity, COUNT(*) AS numberOfOccurences
        FROM (
            SELECT *
            FROM AgeGravity
            WHERE age >= 10 AND age < 20
        ) GROUP BY gravity
    UNION
        SELECT "[20,50[" AS ageGroup, gravity, COUNT(*) AS numberOfOccurences
        FROM (
            SELECT *
            FROM AgeGravity
            WHERE age >= 20 AND age < 50
        ) GROUP BY gravity
    UNION
        SELECT "[60, +inf[" AS ageGroup, gravity, COUNT(*) AS numberOfOccurences
        FROM (
            SELECT *
            FROM AgeGravity
            WHERE age >= 50
        ) GROUP BY gravity
)
ORDER BY ageGroup ASC
;
