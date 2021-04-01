PRAGMA foreign_keys=ON;
.mode columns
.headers on

DROP TABLE IF EXISTS Prescription;
DROP TABLE IF EXISTS Condition;
DROP TABLE IF EXISTS Participated;
DROP TABLE IF EXISTS Ocurrence;
DROP TABLE IF EXISTS WorksAt;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Nurse;
DROP TABLE IF EXISTS Specialty;
DROP TABLE IF EXISTS Unit;
DROP TABLE IF EXISTS HealthProfessional;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS Hospital;

CREATE TABLE Hospital(
	name TEXT PRIMARY KEY,
    region TEXT CONSTRAINT regionValues CHECK(region = "Norte" or region = "Centro" or region = "Lisboa e Vale do Tejo" or region = "Alentejo" or region = "Algarve" or region = "Açores" or region = "Madeira"),
    openingDate INTEGER,
    address TEXT
);

CREATE TABLE Unit(
    name TEXT , --TODO--
    hospital TEXT REFERENCES Hospital ON DELETE CASCADE ON UPDATE CASCADE,
    openingDate INTEGER,
    phone INTEGER CONSTRAINT PhoneRange CHECK(99999999<phone and phone<1000000000),
    head TEXT REFERENCES HealthProfessional ON DELETE SET NULL ON UPDATE CASCADE, 
    PRIMARY KEY(name, hospital)
);

CREATE TABLE Person(
    cc INTEGER PRIMARY KEY CONSTRAINT ccRange CHECK(9999999 < cc and cc < 100000000),
    name TEXT,
    birthDate INTEGER
);

CREATE TABLE Patient( 
    cc INTEGER PRIMARY KEY REFERENCES Person ON DELETE CASCADE ON UPDATE CASCADE CONSTRAINT ccRange CHECK(9999999 < cc and cc < 100000000), --TODO ON DELETE CASCADE or SET NULL--
    insuranceName TEXT,
    healthUserNumber INTEGER CONSTRAINT healthUserNumber CHECK(99999999 < healthUserNumber and healthUserNumber < 1000000000)
);

CREATE TABLE HealthProfessional(
    cc INTEGER PRIMARY KEY REFERENCES Person ON DELETE CASCADE ON UPDATE CASCADE CONSTRAINT ccRange CHECK(9999999 < cc and cc < 100000000), --TODO ON DELETE CASCADE or SET NULL--
    yearsOfService INTEGER CONSTRAINT yearsOfServiceRange CHECK(yearsOfService >= 0),
    baseSalary INTEGER CONSTRAINT baseSalaryRange CHECK(baseSalary >= 665),
    extraSalary INTEGER --TODO--
);

CREATE TABLE WorksAt(
    healthProfessional INTEGER REFERENCES HealthProfessional ON DELETE CASCADE ON UPDATE CASCADE,
    unitName TEXT,
    hospitalName TEXT,
    PRIMARY KEY(healthProfessional, unitName, hospitalName),
    FOREIGN KEY (unitName, hospitalName) REFERENCES Unit ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Ocurrence(
    id INTEGER PRIMARY KEY,
    type TEXT,
    date INTEGER,
    gravity TEXT,
    outcome TEXT,
    unit TEXT REFERENCES Unit(name) ON DELETE SET NULL ON UPDATE CASCADE,
    patient INTEGER REFERENCES Patient ON DELETE SET NULL ON UPDATE CASCADE,
    followUp INTEGER REFERENCES Ocurrence ON DELETE SET NULL ON UPDATE CASCADE CONSTRAINT followUpCheck CHECK(id != followUp) 
);

CREATE TABLE Participated(
    ocurrence INTEGER REFERENCES Ocurrence ON DELETE SET NULL ON UPDATE CASCADE,
    healthProfessional INTEGER REFERENCES HealthProfessional ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (ocurrence, healthProfessional)
);

CREATE TABLE Condition (
    name TEXT PRIMARY KEY,
    gravity TEXT CONSTRAINT gravityValues CHECK(gravity = "high" or gravity = "medium" or gravity = "low")
);

CREATE TABLE Prescription (
    patientCC INTEGER REFERENCES Patient ON DELETE CASCADE ON UPDATE CASCADE CONSTRAINT ccRange CHECK(9999999 < patientCC and patientCC < 100000000),
    condition TEXT REFERENCES Condition ON DELETE CASCADE ON UPDATE CASCADE,
    name TEXT,
    quantity INTEGER CONSTRAINT quantityRange CHECK(quantity > 0),
    PRIMARY KEY (patientCC, condition)
);

CREATE TABLE Doctor ( --TODO ON DELETE CASCADE or SET NULL--
    healthProfessionalCC INTEGER PRIMARY KEY REFERENCES HealthProfessional ON DELETE CASCADE ON UPDATE CASCADE CONSTRAINT healthProfessionalCCRange CHECK (9999999 < healthProfessionalCC and healthProfessionalCC < 100000000),
    type TEXT CONSTRAINT DoctorType CHECK (type = "intern" or type = "resident" or type = "attending"),
    specialty TEXT REFERENCES Specialty ON DELETE SET NULL ON UPDATE CASCADE --TODO CONSTRAINT
);

CREATE TABLE Nurse ( --TODO ON DELETE CASCADE or SET NULL--
    healthProfessionalCC INTEGER PRIMARY KEY REFERENCES HealthProfessional ON DELETE CASCADE ON UPDATE CASCADE CONSTRAINT healthProfessionalCCRange CHECK (9999999 < healthProfessionalCC and healthProfessionalCC < 100000000),
    specialty TEXT REFERENCES Specialty ON DELETE SET NULL ON UPDATE CASCADE --TODO CONSTRAINT
);

CREATE TABLE Specialty(
    name TEXT PRIMARY KEY, --TODO CONSTRAINT
    extraSalarayPerYear INTEGER CONSTRAINT PositiveExtraSalaray CHECK (extraSalarayPerYear > 0)
);

-- ASK:
-- As constraints de referencias têm que ser repetidas? Ou basta por na "base"?
--
