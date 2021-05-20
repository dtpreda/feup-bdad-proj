.mode columns
.headers on
.nullvalue NULL


SELECT avg(baseSalary) as avgSalary, Specialty 
from (
    Select healthProfessionalCC as cc, Specialty 
    from Doctor 
    WHERE Specialty not NULL
    union
    Select healthProfessionalCC as cc, Specialty 
    from Nurse 
    WHERE Specialty not NULL
    ) 
join HealthProfessional using (cc) 
group by Specialty;