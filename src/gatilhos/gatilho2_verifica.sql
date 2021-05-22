PRAGMA foreign_keys=ON;
.mode columns
.headers ON

INSERT INTO Person (cc, name, birthDate) VALUES (46431142, 'Tim Jackson', '2001-08-21 11:21:33');
INSERT INTO HealthProfessional (cc, yearsOfService, baseSalary) VALUES (46431142, 20, 5000);
INSERT INTO Specialty (name, extraSalaryPerYear) VALUES ('Pediatrics', 559);

SELECT * FROM HealthProfessional WHERE cc = 46431142; 

INSERT INTO Doctor (healthProfessionalCC, type, specialty) VALUES (46431142, 'intern', 'Pediatrics');

SELECT * FROM HealthProfessional WHERE cc = 46431142; 

SELECT cc, baseSalary, yearsOfService, specialty, extraSalaryPerYear, extraSalary
FROM HealthProfessional 
JOIN Doctor ON (HealthProfessional.cc = Doctor.healthProfessionalCC) 
JOIN Specialty ON(Doctor.specialty = Specialty.name);
