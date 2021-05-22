PRAGMA foreign_keys=ON;
.mode columns
.headers ON

insert into HealthProfessional (cc, yearsOfService, baseSalary) values (88131651, 20, 5000);

SELECT * FROM HealthProfessional WHERE cc = 88131651; 

insert into Doctor (healthProfessionalCC, type, specialty) values (88131651, 'intern', 'Gynaecology');

SELECT * FROM HealthProfessional WHERE cc = 88131651; 
