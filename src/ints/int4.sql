.mode columns
.headers on
.nullvalue NULL

-- Listar os chefes de unidades com o total pago a todos os HPs da sua unidade e contagem de HPs.

SELECT head, SUM(baseSalary+extraSalary) AS totalPaid, COUNT(*) AS numberOfHealthProfessionals
FROM Unit JOIN WorksAt
ON (Unit.name=WorksAt.unitName AND Unit.hospital=WorksAt.hospitalName)
JOIN HealthProfessional ON (HealthProfessional.cc=healthProfessional)
GROUP BY head;
