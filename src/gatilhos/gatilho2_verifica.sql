PRAGMA foreign_keys=ON;
.mode columns
.headers ON

insert into HealthProfessional (cc, yearsOfService, baseSalary) values (88131651, 20, 5000);

SELECT * FROM HealthProfessional WHERE cc = 88131651; 

insert into Doctor (healthProfessionalCC, type, specialty) values (88131651, 'intern', 'Gynaecology');

SELECT * FROM HealthProfessional WHERE cc = 88131651; 

SELECT cc, baseSalary, yearsOfService, specialty, extraSalaryPerYear, extraSalary
FROM HealthProfessional 
JOIN Doctor ON (HealthProfessional.cc = Doctor.healthProfessionalCC) 
JOIN Specialty ON(Doctor.specialty = Specialty.name);
