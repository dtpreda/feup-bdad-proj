PRAGMA foreign_keys=ON;
.mode columns
.headers ON

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

CREATE TABLE Hospital (
	name TEXT PRIMARY KEY NOT NULL,
<<<<<<< HEAD
    region TEXT CONSTRAINT regionValues CHECK(region = 'Norte' or region = 'Centro' or region = 'Lisboa e Vale do Tejo' or region = 'Alentejo' or region = 'Algarve' or region = 'Açores' or region = 'Madeira'),
=======
    region TEXT CONSTRAINT regionValues CHECK(region = 'Norte' OR region = 'Centro' OR region = 'Lisboa e Vale do Tejo' OR region = 'Alentejo' OR region = 'Algarve' OR region = 'Açores' OR region = 'Madeira'),
>>>>>>> 3b20e58f17de0fe1764a884a3bfe86dae6fef44a
    openingDate INTEGER,
    address TEXT UNIQUE NOT NULL
);

CREATE TABLE Unit (
    name TEXT NOT NULL, --TODO--
    hospital TEXT REFERENCES Hospital ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    openingDate INTEGER,
    phone INTEGER UNIQUE CONSTRAINT PhoneRange CHECK(99999999 < phone AND phone < 1000000000) NOT NULL,
    head TEXT UNIQUE REFERENCES HealthProfessional ON DELETE SET NULL ON UPDATE CASCADE, --TODO Decidir ON DELETE 
    PRIMARY KEY(name, hospital)
);

CREATE TABLE Person (
    cc INTEGER PRIMARY KEY CONSTRAINT ccRange CHECK(9999999 < cc AND cc < 100000000) NOT NULL,
    name TEXT NOT NULL,
    birthDate INTEGER NOT NULL
);

CREATE TABLE Patient ( 
    cc INTEGER PRIMARY KEY REFERENCES Person ON DELETE CASCADE ON UPDATE CASCADE CONSTRAINT ccRange CHECK(9999999 < cc AND cc < 100000000) NOT NULL, --TODO ON DELETE CASCADE or SET NULL--
    insuranceName TEXT DEFAULT 'No insurance',
    healthUserNumber INTEGER UNIQUE CONSTRAINT healthUserNumber CHECK(99999999 < healthUserNumber AND healthUserNumber < 1000000000) NOT NULL
);

CREATE TABLE HealthProfessional (
    cc INTEGER PRIMARY KEY REFERENCES Person ON DELETE CASCADE ON UPDATE CASCADE CONSTRAINT ccRange CHECK(9999999 < cc AND cc < 100000000) NOT NULL, --TODO ON DELETE CASCADE or SET NULL--
    yearsOfService INTEGER CONSTRAINT yearsOfServiceRange CHECK(yearsOfService >= 0) DEFAULT 0 NOT NULL,
    baseSalary INTEGER CONSTRAINT baseSalaryRange CHECK(baseSalary >= 665) DEFAULT 665 NOT NULL,
    extraSalary INTEGER DEFAULT NULL
);

CREATE TABLE WorksAt (
    healthProfessional INTEGER REFERENCES HealthProfessional ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    unitName TEXT NOT NULL,
    hospitalName TEXT NOT NULL,
    PRIMARY KEY(healthProfessional, unitName, hospitalName),
    FOREIGN KEY (unitName, hospitalName) REFERENCES Unit ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Ocurrence (
    id INTEGER PRIMARY KEY NOT NULL,
    type TEXT, --TODO Aplicar constraint -> indicado no UML
    date INTEGER,
    gravity TEXT, --TODO Aplicar constraint -> indicado no UML
    outcome TEXT, --TODO Vale a pena adicionar constraint??
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
<<<<<<< HEAD
    gravity TEXT CONSTRAINT gravityValues CHECK(gravity = 'high' or gravity = 'medium' or gravity = 'low')
=======
    gravity TEXT CONSTRAINT gravityValues CHECK(gravity = 'high' OR gravity = 'medium' OR gravity = 'low')
>>>>>>> 3b20e58f17de0fe1764a884a3bfe86dae6fef44a
);

CREATE TABLE Prescription (
    patientCC INTEGER REFERENCES Patient ON DELETE CASCADE ON UPDATE CASCADE CONSTRAINT ccRange CHECK(9999999 < patientCC AND patientCC < 100000000) NOT NULL,
    condition TEXT REFERENCES Condition ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    name TEXT NOT NULL,
    quantity INTEGER CONSTRAINT quantityRange CHECK(quantity > 0) DEFAULT 1 NOT NULL ,
    PRIMARY KEY (patientCC, condition)
);

CREATE TABLE Doctor ( --TODO ON DELETE CASCADE or SET NULL--
    healthProfessionalCC INTEGER PRIMARY KEY REFERENCES HealthProfessional ON DELETE CASCADE ON UPDATE CASCADE CONSTRAINT healthProfessionalCCRange CHECK (9999999 < healthProfessionalCC and healthProfessionalCC < 100000000) NOT NULL,
<<<<<<< HEAD
    type TEXT CONSTRAINT DoctorType CHECK (type = 'intern' or type = 'resident' or type = 'attending') DEFAULT 'intern' NOT NULL,
=======
    type TEXT CONSTRAINT DoctorType CHECK (type = 'intern' OR type = 'resident' OR type = 'attending') DEFAULT 'intern' NOT NULL,
>>>>>>> 3b20e58f17de0fe1764a884a3bfe86dae6fef44a
    specialty TEXT REFERENCES Specialty ON DELETE SET NULL ON UPDATE CASCADE DEFAULT NULL--TODO CONSTRAINT
);

CREATE TABLE Nurse ( --TODO ON DELETE CASCADE or SET NULL--
    healthProfessionalCC INTEGER PRIMARY KEY REFERENCES HealthProfessional ON DELETE CASCADE ON UPDATE CASCADE CONSTRAINT healthProfessionalCCRange CHECK (9999999 < healthProfessionalCC and healthProfessionalCC < 100000000) NOT NULL,
    specialty TEXT REFERENCES Specialty ON DELETE SET NULL ON UPDATE CASCADE DEFAULT NULL--TODO CONSTRAINT
);

CREATE TABLE Specialty (
    name TEXT PRIMARY KEY, --TODO CONSTRAINT
    extraSalarayPerYear INTEGER CONSTRAINT PositiveExtraSalaray CHECK (extraSalarayPerYear > 0) DEFAULT 1
);

-- ASK:
-- As constraints de referencias têm que ser repetidas? Ou basta por na "base"?
--
