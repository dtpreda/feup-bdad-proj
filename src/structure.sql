PRAGMA foreign_keys=on;
.mode columns
.headers on

CREATE TABLE Hospital(
	name TEXT,
    region TEXT,
    openingDate INTEGER,
    address TEXT
);

CREATE TABLE Unit(
    name TEXT,
    hospital TEXT,
    openingDate INTEGER,
    phone INTEGER,
    head TEXT
);

CREATE TABLE Person(
    cc INTEGER,
    name TEXT,
    birthDate INTEGER
);

CREATE TABLE Patient( 
    cc INTEGER,
    insuranceName TEXT,
    healthUserNumber INTEGER
);

CREATE TABLE HealthProfessional(
    cc INTEGER,
    baseSalary INTEGER,
    extraSalary INTEGER
);

CREATE TABLE WorksAt(
    healthProfessional TEXT,
    unitName TEXT,
    hospitalName TEXT
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

CREAT TABLE Condition (
    name TEXT,
    gravity TEXT
);

CREAT TABLE Prescription (
    patientCC INTEGER,
    condition TEXT,
    name TEXT,
    quantity INTEGER
);

CREAT TABLE Doctor (
    healthProfessionalCC INTEGER,
    type TEXT,
    specialty TEXT
);

CREAT TABLE Nurse (
    healthProfessionalCC INTEGER,
    specialty TEXT
);

CREATE TABLE Specialty(
    name TEXT,
    extraSalarayPerYear INTEGER
);
