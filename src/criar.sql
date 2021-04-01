PRAGMA foreign_keys=ON;
.mode columns
.headers on

CREATE TABLE Hospital(
	name TEXT PRIMARY KEY,
    region TEXT,
    openingDate INTEGER,
    address TEXT
);

CREATE TABLE Unit(
    name TEXT,
    hospital TEXT REFERENCES Hospital,
    openingDate INTEGER,
    phone INTEGER,
    head TEXT REFERENCES HealthProfessional, 
    PRIMARY KEY(name, hospital)
);

CREATE TABLE Person(
    cc INTEGER PRIMARY KEY,
    name TEXT,
    birthDate INTEGER
);

CREATE TABLE Patient( 
    cc INTEGER PRIMARY KEY REFERENCES Person,
    insuranceName TEXT,
    healthUserNumber INTEGER
);

CREATE TABLE HealthProfessional(
    cc INTEGER PRIMARY KEY REFERENCES Person,
    baseSalary INTEGER,
    extraSalary INTEGER
);

CREATE TABLE WorksAt(
    healthProfessional TEXT REFERENCES HealthProfessional,
    unitName TEXT,
    hospitalName TEXT,
    PRIMARY KEY(healthProfessional, unitName, hospitalName),
    FOREIGN KEY (unitName, hospitalName) REFERENCES Unit
);

CREATE TABLE Ocurrence(
    id INTEGER PRIMARY KEY,
    type TEXT,
    date INTEGER,
    gravity TEXT,
    outcome TEXT,
    unit TEXT REFERENCES Unit(name),
    patient INTEGER REFERENCES Patient,
    followUp INTEGER REFERENCES Ocurrence
);

CREATE TABLE Participated(
    ocurrence INTEGER REFERENCES Ocurrence,
    healthProfessional INTEGER REFERENCES HealthProfessional,
    PRIMARY KEY (ocurrence, healthProfessional)
);

CREATE TABLE Condition (
    name TEXT PRIMARY KEY,
    gravity TEXT
);

CREATE TABLE Prescription (
    patientCC INTEGER REFERENCES Patient,
    condition TEXT REFERENCES Condition,
    name TEXT,
    quantity INTEGER,
    PRIMARY KEY (patientCC, condition)
);

CREATE TABLE Doctor (
    healthProfessionalCC INTEGER PRIMARY KEY REFERENCES HealthProfessional CONSTRAINT healthProfessionalCCRange CHECK (9999999 < healthProfessionalCC and healthProfessionalCC < 100000000),
    type TEXT CONSTRAINT DoctorType CHECK (type = "intern" or type = "resident" or type = "attending"),
    specialty TEXT REFERENCES Specialty --TODO CONSTRAINT
);

CREATE TABLE Nurse (
    healthProfessionalCC INTEGER PRIMARY KEY REFERENCES HealthProfessional CONSTRAINT healthProfessionalCCRange CHECK (9999999 < healthProfessionalCC and healthProfessionalCC < 100000000),
    specialty TEXT REFERENCES Specialty --TODO CONSTRAINT
);

CREATE TABLE Specialty(
    name TEXT PRIMARY KEY, --TODO CONSTRAINT
    extraSalarayPerYear INTEGER CONSTRAINT PositiveExtraSalaray CHECK (extraSalarayPerYear > 0)
);

-- ASK:
-- As constraints de referencias têm que ser repetidas? Ou basta por na "base"?
--