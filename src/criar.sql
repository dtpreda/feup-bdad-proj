PRAGMA foreign_keys=ON;
.mode columns
.headers ON

DROP TABLE IF EXISTS Medication;
DROP TABLE IF EXISTS Condition;
DROP TABLE IF EXISTS Participated;
DROP TABLE IF EXISTS Ocurrence;
DROP TABLE IF EXISTS WorksAt;
DROP TABLE IF EXISTS EmployedAt;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Nurse;
DROP TABLE IF EXISTS Specialty;
DROP TABLE IF EXISTS Unit;
DROP TABLE IF EXISTS HealthProfessional;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS Hospital;

CREATE TABLE Hospital (
	name TEXT PRIMARY KEY NOT NULL,
    region TEXT CONSTRAINT regionValues CHECK(region IN('Norte', 'Centro', 'Lisboa e Vale do Tejo', 'Alentejo', 'Algarve', 'Açores' , 'Madeira')) NOT NULL,
    openingDate INTEGER CONSTRAINT beforeNow CHECK((openingDate IS NULL) OR strftime('%Y-%m-%d %H:%M:%S', openingDate) < strftime()),
    address TEXT UNIQUE NOT NULL
);

CREATE TABLE Unit (
    name TEXT CONSTRAINT speciality CHECK(name IN ('Cardiology', 'Pediatrics', 'Neurology', 'Obstetrics', 'Urgencies', 'Intensive Care', 'Radiology', 'Oncology', 'General Medicine', 'Allergology', 'Internment', 'Dermatology', 'Urology', 'Gynaecology', 'Psychiatry')) NOT NULL,
    hospital TEXT REFERENCES Hospital ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    openingDate INTEGER CONSTRAINT beforeNow CHECK((openingDate IS NULL) OR strftime('%Y-%m-%d %H:%M:%S', openingDate) < strftime()),
    phone INTEGER UNIQUE CONSTRAINT PhoneRange CHECK(99999999 < phone AND phone < 1000000000) NOT NULL,
    head INTEGER UNIQUE REFERENCES HealthProfessional ON UPDATE CASCADE ON DELETE RESTRICT NOT NULL, 
    PRIMARY KEY(name, hospital)
);

CREATE TABLE Person (
    cc INTEGER PRIMARY KEY CONSTRAINT ccRange CHECK(9999999 < cc AND cc < 100000000) NOT NULL,
    name TEXT NOT NULL,
    birthDate INTEGER CONSTRAINT beforeNow CHECK(strftime('%Y-%m-%d %H:%M:%S', birthDate) < strftime()) NOT NULL
);

CREATE TABLE Patient (
    cc INTEGER PRIMARY KEY REFERENCES Person ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    insuranceName TEXT DEFAULT NULL,
    healthUserNumber INTEGER UNIQUE CONSTRAINT healthUserNumber CHECK(99999999 < healthUserNumber AND healthUserNumber < 1000000000) NOT NULL
);

CREATE TABLE HealthProfessional (
    cc INTEGER PRIMARY KEY REFERENCES Person ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    yearsOfService INTEGER CONSTRAINT yearsOfServiceRange CHECK(yearsOfService >= 0) DEFAULT 0 NOT NULL,
    baseSalary INTEGER CONSTRAINT baseSalaryRange CHECK(baseSalary >= 665) DEFAULT 665 NOT NULL,
    extraSalary INTEGER CONSTRAINT extraSalaryPositive CHECK(extraSalary >= 0) DEFAULT 0 NOT NULL 
);

CREATE TABLE EmployedAt (
    healthProfessional INTEGER REFERENCES HealthProfessional ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    hospitalName TEXT REFERENCES Hospital ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    id INTEGER NOT NULL,
    PRIMARY KEY(healthProfessional, hospitalName),
    UNIQUE(hospitalName, id)
);

CREATE TABLE WorksAt (
    healthProfessional INTEGER REFERENCES HealthProfessional ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    unitName TEXT NOT NULL,
    hospitalName TEXT NOT NULL,
    PRIMARY KEY (healthProfessional, unitName, hospitalName),
    FOREIGN KEY (unitName, hospitalName) REFERENCES Unit ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Ocurrence (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT CONSTRAINT typeOfOccurrence CHECK(type IN ('appointment', 'surgery', 'emergency', 'analysis', 'exam', 'therapy')) NOT NULL,
    date INTEGER CONSTRAINT beforeNow CHECK(strftime('%Y-%m-%d %H:%M:%S', date) < strftime()) NOT NULL, 
    gravity TEXT CONSTRAINT gravityValues CHECK(gravity IN ('high', 'medium', 'low')) NOT NULL, 
    outcome TEXT,
    unit TEXT,
    hospital TEXT,
    patient INTEGER REFERENCES Patient ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    followUp INTEGER UNIQUE REFERENCES Ocurrence ON DELETE SET NULL ON UPDATE CASCADE CONSTRAINT followUpCheck CHECK((id IS NULL) OR id <> followUp) DEFAULT NULL,
    UNIQUE (patient, date),
    FOREIGN KEY (unit, hospital) REFERENCES Unit ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Participated (
    ocurrence INTEGER REFERENCES Ocurrence ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    healthProfessional INTEGER REFERENCES HealthProfessional ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    PRIMARY KEY (ocurrence, healthProfessional)
);

CREATE TABLE Condition (
    name TEXT PRIMARY KEY NOT NULL,
    gravity TEXT CONSTRAINT gravityValues CHECK(gravity IN ('high', 'medium', 'low')) NOT NULL
);

CREATE TABLE Medication (
    patientCC INTEGER REFERENCES Patient ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    condition TEXT REFERENCES Condition ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    name TEXT DEFAULT NULL,
    quantity INTEGER CONSTRAINT quantityRange CHECK((quantity IS NULL) OR quantity > 0) DEFAULT NULL,
    PRIMARY KEY (patientCC, condition),
    CONSTRAINT nameQuantityCoherence CHECK((quantity IS NULL AND name IS NULL) OR (quantity IS NOT NULL AND name IS NOT NULL))
);

CREATE TABLE Doctor (
    healthProfessionalCC INTEGER PRIMARY KEY REFERENCES HealthProfessional ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    type TEXT CONSTRAINT DoctorType CHECK(type IN ('intern', 'resident', 'attending')) NOT NULL,
    specialty TEXT REFERENCES Specialty ON DELETE SET NULL ON UPDATE CASCADE DEFAULT NULL
);

CREATE TABLE Nurse (
    healthProfessionalCC INTEGER PRIMARY KEY REFERENCES HealthProfessional ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    specialty TEXT REFERENCES Specialty ON DELETE SET NULL ON UPDATE CASCADE DEFAULT NULL
);

CREATE TABLE Specialty (
    name TEXT PRIMARY KEY CONSTRAINT speciality CHECK(name IN ('Cardiology', 'Pediatrics', 'Neurology', 'Obstetrics', 'Urgencies', 'Intensive Care', 'Radiology', 'Oncology', 'General Medicine', 'Allergology', 'Internment', 'Dermatology', 'Urology', 'Gynaecology', 'Psychiatry')) NOT NULL,
    extraSalaryPerYear INTEGER CONSTRAINT PositiveExtraSalaray CHECK(extraSalaryPerYear > 0) DEFAULT 1
);
