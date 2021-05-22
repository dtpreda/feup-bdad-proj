PRAGMA foreign_keys=ON;
.mode columns
.headers ON

INSERT INTO HealthProfessional (cc, yearsOfService, baseSalary) VALUES (88131651, 20, 5000);

SELECT * FROM HealthProfessional WHERE cc = 88131651; 

INSERT INTO Doctor (healthProfessionalCC, type, specialty) VALUES (88131651, 'intern', 'Gynaecology');

SELECT * FROM HealthProfessional WHERE cc = 88131651; 
