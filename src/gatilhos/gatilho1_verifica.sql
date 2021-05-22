PRAGMA foreign_keys=on;
.mode columns
.headers ON

INSERT INTO Hospital (name, region, openingDate, address) VALUES('Sao Joao', 'Norte', '1959-06-24 18:00:00', 'Alameda Prof. Hernani Monteiro');
INSERT INTO Person (cc, name, birthDate) VALUES(12345678, 'Dr. Drake Ramory', '1968-07-14 10:37:45');
INSERT INTO HealthProfessional(cc, yearsOfService, baseSalary) VALUES(12345678, 30, 4120);
INSERT INTO Patient (cc, insuranceName, healthUserNumber) VALUES (12345678, 'The One With Insurance', 123456789); 
INSERT INTO Unit (name, hospital, openingDate, phone, head) VALUES('Neurology', 'Sao Joao', '2011-05-31 19:26:22', 225512100, 12345678);

INSERT INTO Ocurrence (id, type, date, gravity, outcome, unit, hospital, patient) VALUES (987654321, 'analysis', '2021-02-27 12:35:31', 'low', 'Tumour was found to be benign', 'Neurology', 'Sao Joao', 12345678);
INSERT INTO Ocurrence (id, type, date, gravity, outcome, unit, hospital, patient) VALUES (123456789, 'appointment', '2021-02-18 23:08:44', 'low', 'Prescription given for back pain', 'Neurology', 'Sao Joao', 12345678);
UPDATE Ocurrence SET followUp = 987654321 WHERE id = 123456789;

SELECT * 
FROM FollowUpTable
ORDER BY currentID;
