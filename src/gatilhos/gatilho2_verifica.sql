PRAGMA foreign_keys=ON;
.mode columns
.headers ON

INSERT INTO HealthProfessional (cc, yearsOfService, baseSalary) VALUES (88131651, 20, 5000);

SELECT * FROM HealthProfessional WHERE cc = 88131651; 

INSERT INTO Doctor (healthProfessionalCC, type, specialty) VALUES (88131651, 'intern', 'Gynaecology');

SELECT * FROM HealthProfessional WHERE cc = 88131651; 

SELECT cc, baseSalary, yearsOfService, specialty, extraSalaryPerYear, extraSalary
FROM HealthProfessional 
JOIN Doctor ON (HealthProfessional.cc = Doctor.healthProfessionalCC) 
JOIN Specialty ON(Doctor.specialty = Specialty.name);
