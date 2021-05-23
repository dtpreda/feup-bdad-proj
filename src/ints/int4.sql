.mode columns
.headers on
.nullvalue NULL

-- How many health professionals and how much money (spent on health 
-- professionals’ salaries) are every head of Unit responsible for?

SELECT head, Unit.name AS unitName, Unit.hospital AS hospitalName, SUM(baseSalary+extraSalary) AS totalPaid, COUNT(*) AS numberOfHealthProfessionals
FROM Unit JOIN WorksAt
ON (Unit.name=WorksAt.unitName AND Unit.hospital=WorksAt.hospitalName)
JOIN HealthProfessional ON (HealthProfessional.cc=healthProfessional)
GROUP BY head
ORDER BY totalPaid DESC;
