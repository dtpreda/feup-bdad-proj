PRAGMA foreign_keys=ON;

-- A healthProfessional being unable to participate in an occurrence where he/she is also the patient.

CREATE TRIGGER healthProfessionalNotParticipatingWhenPatient
BEFORE INSERT ON Participated
WHEN 
    NEW.healthProfessional=(
        SELECT patient
        FROM Ocurrence
        WHERE Ocurrence.id=NEW.ocurrence
    )
BEGIN
    SELECT RAISE(ROLLBACK, 'A person cannot participate as a health professional in an occurrence where it is a patient.');
END;
