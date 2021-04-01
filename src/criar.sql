PRAGMA foreign_keys=ON;
.mode columns
.headers on

CREATE TABLE Hospital(
	name TEXT PRIMARY KEY,
    region TEXT CONSTRAINT regionValues CHECK(region = "Norte" or region = "Centro" or region = "Lisboa e Vale do Tejo" or region = "Alentejo" or region = "Algarve" or region = "Açores" or region = "Madeira"),
    openingDate INTEGER,
    address TEXT
);

CREATE TABLE Unit(
    name TEXT , --TODO--
    hospital TEXT REFERENCES Hospital,
    openingDate INTEGER,
    phone INTEGER CONSTRAINT PhoneRange CHECK(99999999<phone and phone<1000000000),
    head TEXT REFERENCES HealthProfessional, 
    PRIMARY KEY(name, hospital)
);

CREATE TABLE Person(
    cc INTEGER PRIMARY KEY CONSTRAINT ccRange CHECK(9999999 < cc and cc < 100000000),
    name TEXT,
    birthDate INTEGER
);

CREATE TABLE Patient( 
    cc INTEGER PRIMARY KEY REFERENCES Person CONSTRAINT ccRange CHECK(9999999 < cc and cc < 100000000),
    insuranceName TEXT,
    healthUserNumber INTEGER CONSTRAINT healthUserNumber CHECK(99999999 < healthUserNumber and healthUserNumber < 1000000000)
);

CREATE TABLE HealthProfessional(
    cc INTEGER PRIMARY KEY REFERENCES Person CONSTRAINT ccRange CHECK(9999999 < cc and cc < 100000000),
    yearsOfService INTEGER CONSTRAINT yearsOfServiceRange CHECK(yearsOfService >= 0),
    baseSalary INTEGER CONSTRAINT baseSalaryRange CHECK(baseSalary >= 665),
    extraSalary INTEGER --TODO--
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
    followUp INTEGER REFERENCES Ocurrence CONSTRAINT followUpCheck CHECK(id != followUp)
);

CREATE TABLE Participated(
    ocurrence INTEGER REFERENCES Ocurrence,
    healthProfessional INTEGER REFERENCES HealthProfessional,
    PRIMARY KEY (ocurrence, healthProfessional)
);

CREATE TABLE Condition (
    name TEXT PRIMARY KEY,
    gravity TEXT CONSTRAINT gravityValues CHECK(gravity = "high" or gravity = "medium" or gravity = "low")
);

CREATE TABLE Prescription (
    patientCC INTEGER REFERENCES Patient CONSTRAINT ccRange CHECK(9999999 < patientCC and patientCC < 100000000),
    condition TEXT REFERENCES Condition,
    name TEXT,
    quantity INTEGER CONSTRAINT quantityRange CHECK(quantity > 0),
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
