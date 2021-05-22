PRAGMA foreign_keys=on;
.mode columns
.headers on
.nullvalue NULL

INSERT INTO Hospital (name, region, openingDate, address) VALUES('Sao Antonio', 'Norte', '1824-06-24 18:00:00', 'Largo do Prof. Abel Salazar');
INSERT INTO Person (cc, name, birthDate) VALUES(87654111, 'Park Seo-Joon', '1968-07-14 10:37:45');
INSERT INTO HealthProfessional(cc, yearsOfService, baseSalary) VALUES(87654111, 30, 4120);
INSERT INTO Patient (cc, insuranceName, healthUserNumber) VALUES (87654111, 'The One With Insurance', 123456789); 
INSERT INTO Unit (name, hospital, openingDate, phone, head) VALUES('Neurology', 'Sao Antonio', '2010-05-31 19:26:22', 222077500, 87654111);

INSERT INTO Ocurrence (id, type, date, gravity, outcome, unit, hospital, patient) VALUES (987654321, 'analysis', '2021-02-27 12:35:31', 'low', 'Tumour was found to be benign', 'Neurology', 'Sao Antonio', 87654111);
INSERT INTO Ocurrence (id, type, date, gravity, outcome, unit, hospital, patient) VALUES (123456789, 'appointment', '2021-02-18 23:08:44', 'low', 'Prescription given for back pain', 'Neurology', 'Sao Antonio', 87654111);
UPDATE Ocurrence SET followUp = 987654321 WHERE id = 123456789;

SELECT * 
FROM FollowUpTable
ORDER BY currentID;
