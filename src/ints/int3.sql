.mode columns
.headers on
.nullvalue NULL

-- Frequencia de gravidade de ocorrencia por faixa etária.

--TODO any better way to do this? (talvez perguntar ao prof)

DROP VIEW IF EXISTS AgeGravity;
DROP VIEW IF EXISTS LessThan10;
DROP VIEW IF EXISTS GreaterThan10LessThan20;
DROP VIEW IF EXISTS GreaterThan20LessThan50;
DROP VIEW IF EXISTS GreaterThan50;


CREATE VIEW AgeGravity AS
SELECT (JulianDay("now")-JulianDay(birthDate))/365.25 AS age, gravity
FROM Ocurrence JOIN Patient ON(Ocurrence.patient=Patient.cc) JOIN Person USING(cc);

CREATE VIEW LessThan10 AS
SELECT *
FROM AgeGravity
WHERE age < 10;

CREATE VIEW GreaterThan10LessThan20 AS
SELECT *
FROM AgeGravity
WHERE age >= 10 AND age < 20;

CREATE VIEW GreaterThan20LessThan50 AS
SELECT *
FROM AgeGravity
WHERE age >= 20 AND age < 50;

CREATE VIEW GreaterThan50 AS
SELECT *
FROM AgeGravity
WHERE age >= 50;

SELECT *
FROM (
        SELECT "[0, 10[" AS ageGroup, gravity, COUNT(*) AS numberOfOccurences
        FROM LessThan10
        GROUP BY gravity
    UNION 
        SELECT "[10,20[" AS ageGroup, gravity, COUNT(*) AS numberOfOccurences
        FROM GreaterThan10LessThan20
        GROUP BY gravity
    UNION
        SELECT "[20,50[" AS ageGroup, gravity, COUNT(*) AS numberOfOccurences
        FROM GreaterThan20LessThan50
        GROUP BY gravity
    UNION
        SELECT "[60, +inf[" AS ageGroup, gravity, COUNT(*) AS numberOfOccurences
        FROM GreaterThan50
        GROUP BY gravity
);
