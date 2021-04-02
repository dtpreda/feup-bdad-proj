PRAGMA foreign_keys=ON;
.mode columns
.headers ON

DROP TABLE IF EXISTS Prescription;
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
    region TEXT CONSTRAINT regionValues CHECK(region = 'Norte' OR region = 'Centro' OR region = 'Lisboa e Vale do Tejo' OR region = 'Alentejo' OR region = 'Algarve' OR region = 'Açores' OR region = 'Madeira'),
    openingDate INTEGER CONSTRAINT beforeNow CHECK(strftime('%Y-%m-%d %H:%M:%S', openingDate) < strftime()),
    address TEXT UNIQUE NOT NULL
);

CREATE TABLE Unit (
    name TEXT CONSTRAINT speciality CHECK(name = 'Cardiology' OR name = 'Pediatry' OR name = 'Neurology' OR name = 'Obstretics' OR name = 'Urgencies' OR name = 'Intensive Care' OR name = 'Radiology' OR name = 'Oncology' OR name = 'General Medicine' OR name = 'Allergology' OR name = 'Internment' OR name = 'Dermatology' OR name = 'Urology' OR name = 'Gynecology' OR name = 'Psychiatry') NOT NULL, 
    hospital TEXT REFERENCES Hospital ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    openingDate INTEGER CONSTRAINT beforeNow CHECK(strftime('%Y-%m-%d %H:%M:%S', openingDate) < strftime()),
    phone INTEGER UNIQUE CONSTRAINT PhoneRange CHECK(99999999 < phone AND phone < 1000000000) NOT NULL,
    head TEXT UNIQUE REFERENCES HealthProfessional ON DELETE SET NULL ON UPDATE CASCADE, 
    PRIMARY KEY(name, hospital)
);

CREATE TABLE Person (
    cc INTEGER PRIMARY KEY CONSTRAINT ccRange CHECK(9999999 < cc AND cc < 100000000) NOT NULL,
    name TEXT NOT NULL,
    birthDate INTEGER NOT NULL CONSTRAINT beforeNow CHECK(strftime('%Y-%m-%d %H:%M:%S', birthDate) < strftime())
);

CREATE TABLE Patient ( 
    cc INTEGER PRIMARY KEY REFERENCES Person ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    insuranceName TEXT DEFAULT 'No insurance',
    healthUserNumber INTEGER UNIQUE CONSTRAINT healthUserNumber CHECK(99999999 < healthUserNumber AND healthUserNumber < 1000000000) NOT NULL
);

CREATE TABLE HealthProfessional (
    cc INTEGER PRIMARY KEY REFERENCES Person ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    yearsOfService INTEGER CONSTRAINT yearsOfServiceRange CHECK(yearsOfService >= 0) DEFAULT 0 NOT NULL,
    baseSalary INTEGER CONSTRAINT baseSalaryRange CHECK(baseSalary >= 665) DEFAULT 665 NOT NULL
);

CREATE TABLE EmployedAt (
    healthProfessional INTEGER REFERENCES HealthProfessional ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    hospitalName TEXT REFERENCES Hospital ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    id INTEGER,
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
    id INTEGER PRIMARY KEY NOT NULL,
    type TEXT CONSTRAINT typeOfOccurrence CHECK(type = 'appointment' OR type = 'surgery' OR type = 'emergency' OR type = 'analysis' OR type = 'exam' OR type = 'therapy'),
    date INTEGER CONSTRAINT beforeNow CHECK(strftime('%Y-%m-%d %H:%M:%S', date) < strftime()), 
    gravity TEXT CONSTRAINT gravityValues CHECK(gravity = 'high' OR gravity = 'medium' OR gravity = 'low'), 
    outcome TEXT,
    unit TEXT REFERENCES Unit(name) ON DELETE SET NULL ON UPDATE CASCADE,
    patient INTEGER REFERENCES Patient ON DELETE SET NULL ON UPDATE CASCADE,
    followUp INTEGER UNIQUE REFERENCES Ocurrence ON DELETE SET NULL ON UPDATE CASCADE CONSTRAINT followUpCheck CHECK(id != followUp)
);

CREATE TABLE Participated (
    ocurrence INTEGER REFERENCES Ocurrence ON DELETE SET NULL ON UPDATE CASCADE,
    healthProfessional INTEGER REFERENCES HealthProfessional ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    PRIMARY KEY (ocurrence, healthProfessional)
);

CREATE TABLE Condition (
    name TEXT PRIMARY KEY,
    gravity TEXT CONSTRAINT gravityValues CHECK(gravity = 'high' OR gravity = 'medium' OR gravity = 'low')
);

CREATE TABLE Prescription (
    patientCC INTEGER REFERENCES Patient ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    condition TEXT REFERENCES Condition ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    name TEXT NOT NULL,
    quantity INTEGER CONSTRAINT quantityRange CHECK(quantity > 0) DEFAULT 1 NOT NULL ,
    PRIMARY KEY (patientCC, condition)
);

CREATE TABLE Doctor (
    healthProfessionalCC INTEGER PRIMARY KEY REFERENCES HealthProfessional ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    type TEXT CONSTRAINT DoctorType CHECK (type = 'intern' OR type = 'resident' OR type = 'attending') DEFAULT 'intern' NOT NULL,
    specialty TEXT REFERENCES Specialty ON DELETE SET NULL ON UPDATE CASCADE DEFAULT NULL
);

CREATE TABLE Nurse (
    healthProfessionalCC INTEGER PRIMARY KEY REFERENCES HealthProfessional ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    specialty TEXT REFERENCES Specialty ON DELETE SET NULL ON UPDATE CASCADE DEFAULT NULL
);

CREATE TABLE Specialty (
    name TEXT PRIMARY KEY CONSTRAINT speciality CHECK(name = 'Cardiology' OR name = 'Pediatry' OR name = 'Neurology' OR name = 'Obstretics' OR name = 'Urgencies' OR name = 'Intensive Care' OR name = 'Radiology' OR name = 'Oncology' OR name = 'General Medicine' OR name = 'Allergology' OR name = 'Internment' OR name = 'Dermatology' OR name = 'Urology' OR name = 'Gynecology' OR name = 'Psychiatry') NOT NULL,
    extraSalarayPerYear INTEGER CONSTRAINT PositiveExtraSalaray CHECK (extraSalarayPerYear > 0) DEFAULT 1
);
