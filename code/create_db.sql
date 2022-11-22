CREATE DATABASE dlars_db;
CREATE USER 'webapp'@'%' IDENTIFIED BY '1cabros23';
GRANT ALL PRIVILEGES ON dlars_db.* TO 'webapp'@'%';
FLUSH PRIVILEGES;

CREATE USER 'sysadmin'@'%' IDENTIFIED BY 'sysadmin789';
CREATE USER 'clerk'@'%' IDENTIFIED BY 'clerk789';
CREATE USER 'user'@'%' IDENTIFIED BY 'user789';


USE dlars_db;

CREATE TABLE PERSON (
    firstName TEXT NOT NULL,
    middleName TEXT,
    lastName TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    state CHAR(4),
    zipCode INTEGER,
    restriction CHAR(4),
    FOREIGN KEY driversID INTEGER
);

CREATE TABLE MISC (
    organDonor BOOLEAN,
    veteran BOOLEAN,
    FOREIGN KEY driversID INTEGER
)


CREATE TABLE BIO_INFORMATION (
    -- One of M, F, X (None Binary)
    Gender CHAR(1),
    eyeColor CHAR(4),
    hairColor Char(4),
    bloodType CHAR(4),
    weight FLOAT,
    height FLOAT,
);

CREATE TABLE PICTURE (
    -- TODO: How to represent a picture correctly
    pictureAddress CHAR(4),
    FOREIGN KEY driversID INTEGER

);

CREATE TABLE USER_CREDENTIALS (
    nickname CHAR(4),
    password int NOT NULL,
    FOREIGN KEY driversID INTEGER
);


CREATE TABLE INCIDENT_HISTORY (
    -- One of A, B, C, D, E, F
    incidentType CHAR(1) NOT NULL,
    incidentDate DATE NOT NULL,
    fineAmount FLOAT NOT NULL,
    FOREIGN KEY driversID INTEGER
);


CREATE TABLE EMERGENCY_CONTACT_INFO (
    firstName TEXT,
    lastName TEXT,
    phoneNumber INTEGER,
    FOREIGN KEY driversID INTEGER
);


CREATE TABLE PRE_VALIDATION_DATA (
    roadTestResult TEXT,
    statusOfLearnersPermit TEXT,
    dmvOffice TEXT,
    FOREIGN KEY driversID INTEGER
);

CREATE TABLE LICENSE_ASSOCIATED_INFORMATION (
    issueDate DATE,
    expirationDate DATE,
    VehicleType CHAR(1),
    FOREIGN KEY driversID INTEGER

);
CREATE TABLE VEHICLE_INFORMATION (
    vehicleType TEXT,
    description TEXT,
    licensePlate TEXT,
    FOREIGN KEY driversID INTEGER
);










