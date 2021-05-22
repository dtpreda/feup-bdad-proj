.mode columns
.headers on
.nullvalue NULL


select DISTINCT patient1 as patient, condition1 as condition, drugName1 as drugName
from (
    select * from
        (select name as patient1, condition as condition1, drugName as drugName1 
        from Person join (
            select patientCC as cc, condition, drugName 
            from Prescription) 
        using (cc))
    join 
        (select name as patient2, drugName2, condition2 
        from Person join (
            select patientCC as cc, condition as condition2, drugName as drugName2
            from Prescription) 
        using (cc))
    where patient1 <> patient2 and condition1 == condition2 and drugName1 == drugName2
) order by (drugName);