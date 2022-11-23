CREATE DATABASE dlars_db;
CREATE USER 'webapp'@'%' IDENTIFIED BY 'iker123';
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
    restriction CHAR(4)
    -- FOREIGN KEY driversID INTEGER
);

CREATE TABLE MISC (
    organDonor BOOLEAN,
    veteran BOOLEAN
    -- FOREIGN KEY driversID INTEGER
);


CREATE TABLE BIO_INFORMATION (
    -- One of M, F, X (None Binary)
    Gender CHAR(1),
    eyeColor CHAR(4),
    hairColor Char(4),
    bloodType CHAR(4),
    weight FLOAT,
    height FLOAT
);

CREATE TABLE PICTURE (
    -- TODO: How to represent a picture correctly
    pictureAddress CHAR(4)
    -- FOREIGN KEY driversID INTEGER
);

CREATE TABLE USER_CREDENTIALS (
    password INTEGER NOT NULL,
    nickname CHAR(4)
    -- FOREIGN KEY driversID INTEGER
);


CREATE TABLE INCIDENT_HISTORY (
    -- One of A, B, C, D, E, F
    incidentType CHAR(1) NOT NULL,
    incidentDate DATE NOT NULL,
    fineAmount FLOAT
    -- FOREIGN KEY driversID INTEGER
);


CREATE TABLE EMERGENCY_CONTACT_INFO (
    firstName TEXT,
    lastName TEXT,
    phoneNumber INTEGER
    -- FOREIGN KEY driversID INTEGER
);


CREATE TABLE PRE_VALIDATION_DATA (
    roadTestResult TEXT,
    statusOfLearnersPermit TEXT,
    dmvOffice TEXT
    -- FOREIGN KEY driversID INTEGER
);

CREATE TABLE LICENSE_ASSOCIATED_INFORMATION (
    issueDate DATE,
    expirationDate DATE,
    VehicleType CHAR(1)
    -- FOREIGN KEY driversID INTEGER

);
CREATE TABLE VEHICLE_INFORMATION (
    vehicleType TEXT,
    description TEXT,
    licensePlate TEXT
    -- FOREIGN KEY driversID INTEGER
);



-- Since as of now, there are no foreign keys that relate all the db, assume that the 

INSERT INTO PERSON ( firstName, middleName, lastName, email,state, zipCode, restriction) -- These would need a DriversID 
VALUES ('Jane', 'Marie', 'Doe', 'j.doe@gmail.com', 'MA', 02111, 'B'),
        ('Joseph', NULL, 'Doe', 'jo.doe@gmail.com', 'MA', 02111, NULL),
        ('John', NULL, 'Smith', 'johnsmith@company.com', 'MA', 02120, 'B');


INSERT INTO MISC (organDonor, veteran)
VALUES  (TRUE, FALSE),
        (FALSE, FALSE),
        (FALSE, TRUE);

-- Used Imperial system (lbs and inches respectively)
-- One of M, F, X (None Binary)
INSERT INTO BIO_INFORMATION (Gender,eyeColor ,hairColor ,bloodType ,weight,height)
VALUES ('F', 'BRO', 'BRO', 'O+','120', '55'),
       ('M', 'BLU', 'BRO', 'AB-','165', '65'),
       ('X', 'BRO', 'BRO', 'A+','135', '60');


INSERT INTO PICTURE (pictureAddress)
VALUES ('3401'),
        ('3402'),
        ('9523');

INSERT INTO USER_CREDENTIALS (password, nickname)
VALUES (123,'JMDO'),
        (453, 'JDOE'),
        (39402, 'JOSM'); 

INSERT INTO INCIDENT_HISTORY (incidentType, incidentDate, fineAmount)
VALUES ('D', 03/23/1989, 500), ('A', 09/09/2009, 75), ('A', 09/12/2022);

INSERT INTO EMERGENCY_CONTACT_INFO (firstName, lastName, phoneNumber) 
VALUES ('Joseph','Doe', 6172558989),('Jane', 'Doe', 6172539000),('Maria', 'Falcao', 3052359898);

INSERT INTO PRE_VALIDATION_DATA (roadTestResult,statusOfLearnersPermit, dmvOffice)
VALUES ('PASS', 'CURRENT', 'Watertown'), ('PASS', 'CURRENT', 'Springfield'),('FAILED', 'INVALID', 'Haymarket');

INSERT INTO LICENSE_ASSOCIATED_INFORMATION (issueDate, expirationDate, vehicleType)
VALUES (03/15/1969, 03/15/2023, 'D'), (03/19/1972, 03/15/2024, 'D'), (NULL, NULL, 'D');

INSERT INTO VEHICLE_INFORMATION (vehicleType, description, licensePlate)
VALUES ('D', '1995 BMW SERIES 3', '1BOOMER'),
       ('D', '2022 FORD BRONCO', '0GOPATS0'),
       ('D', '2009 CADILLAC ESCALADE', '2934JVC');








