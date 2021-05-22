PRAGMA foreign_keys=ON;

SELECT * FROM Participated;

--Test set up so that foreign key referential integrity is respected
INSERT INTO Hospital (name, region, openingDate, address) VALUES('Sao Joao', 'Norte', '1959-06-24 18:00:00', 'Alameda Prof. Hernani Monteiro');
INSERT INTO Person (cc, name, birthDate) VALUES(12345688, 'Dr. Drake Ramory', '1968-07-14 10:37:45');
INSERT INTO HealthProfessional(cc, yearsOfService, baseSalary) VALUES(12345688, 30, 4120);
INSERT INTO Patient (cc, insuranceName, healthUserNumber) values (12345688, 'The One With Insurance', 123456799); 
INSERT INTO Unit (name, hospital, openingDate, phone, head) VALUES('Neurology', 'Sao Joao', '2011-05-31 19:26:22', 225512100, 12345688);

--Actual test
INSERT INTO Ocurrence(id, type, date, gravity, outcome, unit, hospital, patient) VALUES(9999999999, 'surgery', '2020-03-18 09:23:29', 'low', 'test', 'Neurology', 'Sao Joao', 12345688);
INSERT INTO Participated(ocurrence, healthProfessional) VALUES(9999999999, 12345688);

SELECT * FROM Participated;
