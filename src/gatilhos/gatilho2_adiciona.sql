DROP TRIGGER IF EXISTS ExtraSalaryDoctor;
DROP TRIGGER IF EXISTS ExtraSalaryNurse;

CREATE TRIGGER ExtraSalaryDoctor
AFTER INSERT ON Doctor
WHEN NEW.specialty NOT NULL
BEGIN
    UPDATE HealthProfessional set extraSalary = extraSalary +(
    SELECT Specialty.extraSalaryPerYear
    FROM Specialty
    WHERE Specialty.name LIKE NEW.specialty
    ) * yearsOfService where cc = NEW.healthProfessionalCC;
END;

CREATE TRIGGER ExtraSalaryNurse
AFTER INSERT ON Nurse
WHEN NEW.specialty NOT NULL
BEGIN
    UPDATE HealthProfessional set extraSalary = extraSalary +(
    SELECT Specialty.extraSalaryPerYear
    FROM Specialty
    WHERE Specialty.name LIKE NEW.specialty
    ) * yearsOfService where cc = NEW.healthProfessionalCC;
END;
