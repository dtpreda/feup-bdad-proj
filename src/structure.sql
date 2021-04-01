PRAGMA foreign_keys = ON;
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
    id INTEGER,
    type TEXT,
    date INTEGER,
    gravity TEXT,
    outcome TEXT,
    unit TEXT,
    patient INTEGER,
    followUp INTEGER
);

CREATE TABLE Participated(
    ocurrence INTEGER,
    healthPROfessional INTEGER
);

CREATE TABLE Condition (
    name TEXT,
    gravity TEXT
);

CREATE TABLE Prescription (
    patientCC INTEGER,
    condition TEXT,
    name TEXT,
    quantity INTEGER
);

CREATE TABLE Doctor (
    healthProfessionalCC INTEGER,
    type TEXT,
    specialty TEXT
);

CREATE TABLE Nurse (
    healthProfessionalCC INTEGER,
    specialty TEXT
);

CREATE TABLE Specialty(
    name TEXT,
    extraSalarayPerYear INTEGER
);
