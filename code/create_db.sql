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
    state CHAR(4),
    zipCode INTEGER
    driversID INTEGER
);

CREATE TABLE BIO_INFORMATION (
    -- One of M, F, X (None Binary)
    Gender CHAR(1),
    Eye_Color CHAR(4),
    Hair_Color Char(4),
    Blood_Type CHAR(4),
    Weight FLOAT,
    Height FLOAT,
);

CREATE TABLE PICTURE (
    -- TODO: How to represent a picture correctly
    -- TODO: Foreign Key Constraints
    Picture_Address CHAR(4)
);

CREATE TABLE USER_CREDENTIALS (
    Nickname CHAR(4),
    Password int NOT NULL,
    -- TODO: Foreign Key Constraints
);


CREATE TABLE INCIDENT_HISTORY (
    -- One of A, B, C, D, E, F
    Incident_Type CHAR(1) NOT NULL,
    Incident_Date DATE NOT NULL,
    Fine_Amount FLOAT NOT NULL
);


CREATE TABLE EMERGENCY_CONTACT_INFO (
    firstName TEXT,
    lastName TEXT,
    phoneNumber INTEGER
);


CREATE TABLE PRE_VALIDATION_DATA (
    roadTestResult TEXT,
    statusOfLearnersPermit TEXT,
    dmvOffice TEXT
);

CREATE TABLE LICENSE_ASSOCIATED_INFORMATION (
    issueDate DATE,
    expirationDate DATE,
    VehicleType CHAR(1),
    driversID INTEGER

);
CREATE TABLE VEHICLE_INFORMATION (
    vehicleType TEXT,
    description TEXT,
    licensePlate TEXT
);










