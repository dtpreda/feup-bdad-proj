PRAGMA foreign_keys=ON;
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
    healthProfessionalCC INTEGER PRIMARY KEY REFERENCES HealthProfessional,
    type TEXT,
    specialty TEXT REFERENCES Specialty
);

CREATE TABLE Nurse (
    healthProfessionalCC INTEGER PRIMARY KEY REFERENCES HealthProfessional,
    specialty TEXT REFERENCES Specialty
);

CREATE TABLE Specialty(
    name TEXT PRIMARY KEY,
    extraSalarayPerYear INTEGER
);
