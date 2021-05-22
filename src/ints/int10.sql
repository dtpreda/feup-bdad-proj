.mode columns
.headers on
.nullvalue NULL

DROP VIEW IF EXISTS DoctorParticipated;

CREATE View DoctorParticipated AS
SELECT HealthProfessional.cc AS doctorCC, id, Person.cc AS personCC, Person.name AS personName
FROM HealthProfessional 
JOIN Participated ON (HealthProfessional.cc = Participated.healthProfessional) 
JOIN Ocurrence ON (Participated.ocurrence = Ocurrence.id) 
JOIN Person ON (Ocurrence.patient = Person.cc);

SELECT doctorCC 
FROM DoctorParticipated DP1
WHERE (
    SELECT count(*) AS count1
    FROM DoctorParticipated DP2
    WHERE DP1.doctorCC = DP2.doctorCC AND DP2.personCC = 10226927
    GROUP BY doctorCC
) = (
    SELECT count(*) AS count1
    FROM Person JOIN Patient USING(cc)
    JOIN Ocurrence ON (Ocurrence.patient = Person.cc) 
    WHERE Person.cc = 10226927
)
GROUP BY doctorCC;
