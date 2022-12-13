#CREATE DATABASE dlars_db;
#CREATE USER 'webapp'@'%' IDENTIFIED BY 'iker123';
#GRANT ALL PRIVILEGES ON dlars_db.* TO'webapp'@'%';
#FLUSH PRIVILEGES;

#CREATE USER 'sysadmin'@'%' IDENTIFIED BY 'sysadmin789';
#CREATE USER 'clerk'@'%' IDENTIFIED BY 'clerk789';
#CREATE USER 'user'@'%' IDENTIFIED BY 'user789';


USE dlars_db;

DROP TABLE IF EXISTS `Person`;
CREATE TABLE `Person`
(
    firstName   TEXT        NOT NULL,
    middleName  TEXT,
    lastName    TEXT        NOT NULL,
    email       TEXT NOT NULL,
    state       CHAR(4),
    zipCode     INTEGER,
    restriction CHAR(4),
    driversID   INT AUTO_INCREMENT NOT NULL,
    PRIMARY KEY (driversID)
);

DROP TABLE IF EXISTS `Misc`;
CREATE TABLE `Misc`
(
    organDonor BOOLEAN,
    veteran    BOOLEAN,
    driversID  INT NOT NULL,
    CONSTRAINT FK1
        FOREIGN KEY (driversID) REFERENCES `Person` (driversID)
);

DROP TABLE IF EXISTS `BioInformation`;
CREATE TABLE `BioInformation`
(
    -- One of M, F, X (None Binary)
    Gender    CHAR(1),
    eyeColor  CHAR(4),
    hairColor Char(4),
    bloodType CHAR(4),
    weight    FLOAT,
    height    FLOAT,
    driversID INT NOT NULL,
    CONSTRAINT FK2
        FOREIGN KEY (driversID) REFERENCES `Person` (driversID)
);

DROP TABLE IF EXISTS `Picture`;
CREATE TABLE `Picture`
(
    -- TODO: How to represent a picture correctly
    pictureAddress CHAR(4),
    driversID      INT NOT NULL,
    CONSTRAINT FK3
        FOREIGN KEY (driversID) REFERENCES `Person` (driversID)
);

DROP TABLE IF EXISTS `UserCredential`;
CREATE TABLE `UserCredential`
(
    password  INTEGER NOT NULL,
    nickname  CHAR(4),
    driversID INT     NOT NULL,
    CONSTRAINT FK4
        FOREIGN KEY (driversID) REFERENCES `Person` (driversID)
    -- FOREIGN KEY driversID INTEGER
);

DROP TABLE IF EXISTS `IncedentHistory`;
CREATE TABLE `IncedentHistory`
(
    -- One of A, B, C, D, E, F
    incidentType CHAR(1) NOT NULL,
    incidentDate DATE    NOT NULL,
    fineAmount   FLOAT   NOT NULL,
    driversID    INT     NOT NULL,
    CONSTRAINT FK5
        FOREIGN KEY (driversID) REFERENCES `Person` (driversID)

);

DROP TABLE IF EXISTS `EmergencyContactInfo`;
CREATE TABLE `EmergencyContactInfo`
(
    firstName   TEXT,
    lastName    TEXT,
    phoneNumber INTEGER,
    driversID   INT NOT NULL,
    CONSTRAINT FK6
        FOREIGN KEY (driversID) REFERENCES `Person` (driversID)
);

DROP TABLE IF EXISTS `PreValidationData`;
CREATE TABLE `PreValidationData`
(
    roadTestResult         VARCHAR(2) NOT NULL,
    statusOfLearnersPermit VARCHAR(2) NOT NULL,
    dmvOffice              VARCHAR(2) NOT NULL,
    driversID              INT NOT NULL,
    CONSTRAINT FK7
        FOREIGN KEY (driversID) REFERENCES `Person` (driversID)
    -- FOREIGN KEY driversID INTEGER
);

DROP TABLE IF EXISTS `LicenseAssociatedInformation`;
CREATE TABLE  `LicenseAssociatedInformation`
(
    issueDate      DATE,
    expirationDate DATE,
    VehicleType    CHAR(1),
    driversID      INT NOT NULL,
    CONSTRAINT FK8
        FOREIGN KEY (driversID) REFERENCES `Person` (driversID)
    -- FOREIGN KEY driversID INTEGER

);

DROP TABLE IF EXISTS `EmergencyConVehicleInformationtactInfo`;
CREATE TABLE `VehicleInformation`
(
    vehicleType  TEXT NOT NULL,
    description  TEXT NOT NULL,
    licensePlate TEXT NOT NULL,
    driversID    INT NOT NULL,
    CONSTRAINT FK9
        FOREIGN KEY (driversID) REFERENCES `Person` (driversID)
);

DROP TABLE IF EXISTS `ClerkInformation`;
CREATE TABLE `ClerkInformation`
(
    firstName  TEXT NOT NULL,
    LastName   TEXT NOT NULL,
    EmployeeID INT AUTO_INCREMENT NOT NULL,
    PRIMARY KEY (EmployeeID)
);

DROP TABLE IF EXISTS `ApplicationStatus`;
CREATE TABLE `ApplicationStatus`
(
    LicenseStatus        CHAR(20),
    PendingFirstApproval CHAR(20),
    EmployeeID           INT NOT NULL,
    CONSTRAINT FK10
        FOREIGN KEY (EmployeeID) REFERENCES `ClerkInformation` (EmployeeID)
);

DROP TABLE IF EXISTS `AccessCredentials`;
CREATE TABLE `AccessCredentials`
(
    NickName   TEXT NOT NULL,
    Password   TEXT NOT NULL,
    EmployeeID INT  NOT NULL,
    CONSTRAINT FK11
        FOREIGN KEY (EmployeeID) REFERENCES `ClerkInformation` (EmployeeID)
);

INSERT INTO `Person` (firstName, middleName, lastName, email, state, zipCode, restriction, driversID) -- These would need a DriversID
VALUES ('Jane', 'Marie', 'Doe', 'j.doe@gmail.com', 'MA', 02111, 'B', 1001),
       ('Joseph', NULL, 'Doe', 'jo.doe@gmail.com', 'MA', 02111, NULL, 1002),
       ('John', NULL, 'Smith', 'johnsmith@company.com', 'MA', 02120, 'B', 1003),
       ('Carlos', NULL, 'Gimeno', 'chupala@company.com', 'MA', 02120, 'B', 1000);


INSERT INTO `ClerkInformation`(firstName, LastName, EmployeeID)
VALUES ('Roberto', 'Rodriguez', 1000),
    ('Mariana', 'Guerra', 1100),
    ('Alejandro', 'Rodriguez', 1110);


-- Since as of now, there are no foreign keys that relate all the db, assume that the 
INSERT INTO `ApplicationStatus`(LicenseStatus, PendingFirstApproval, EmployeeID)
VALUES ('Approved', 'Pass', 1000),
       ('Approved', 'Fail', 1100),
       ('Rejected', 'Pass', 1110);
-- We are not sure if the auto increment for the primary key is going to affect
-- the value for the foreign key, therefore it will increase automatically.
-- As of now we will leave it like this, for one erd we will put the, and for the other
-- we are just going to assume that the auto increase will work automatically.
INSERT INTO `AccessCredentials`(NickName, Password, EmployeeID)
VALUES ('Ikandrio', '1239', 1000),
       ('Cabra47', 'holA9', 1100),
       ('Carlosquinto','Rey57', 1110);


INSERT INTO `Misc` (organDonor, veteran)
VALUES (TRUE, FALSE, 1000),
       (FALSE, FALSE, 1001),
       (FALSE, TRUE, 1002);

-- Used Imperial system (lbs and inches respectively)
-- One of M, F, X (None Binary)
INSERT INTO `BioInformation` (Gender, eyeColor, hairColor, bloodType, weight, height)
VALUES ('F', 'BRO', 'BRO', 'O+', '120', '55'),
       ('M', 'BLU', 'BRO', 'AB-', '165', '65'),
       ('X', 'BRO', 'BRO', 'A+', '135', '60');


INSERT INTO `Picture` (pictureAddress)
VALUES ('3401'),
       ('3402'),
       ('9523');

INSERT INTO `UserCredential` (password, nickname)
VALUES (123, 'JMDO'),
       (453, 'JDOE'),
       (39402, 'JOSM');

INSERT INTO  `IncedentHistory` (incidentType, incidentDate, fineAmount)
VALUES ('D', 03 / 23 / 1989, 500),
       ('A', 09 / 09 / 2009, 75),
       ('A', 09 / 12 / 2022);

INSERT INTO `EmergencyContactInfo` (firstName, lastName, phoneNumber)
VALUES ('Joseph', 'Doe', 6172558989),
       ('Jane', 'Doe', 6172539000),
       ('Maria', 'Falcao', 3052359898);

INSERT INTO 'PreValidationData' (roadTestResult, statusOfLearnersPermit, dmvOffice)
VALUES ('PASS', 'CURRENT', 'Watertown'),
       ('PASS', 'CURRENT', 'Springfield'),
       ('FAILED', 'INVALID', 'Haymarket');

INSERT INTO   `LicenseAssociatedInformation` (issueDate, expirationDate, vehicleType)
VALUES (03 / 15 / 1969, 03 / 15 / 2023, 'D'),
       (03 / 19 / 1972, 03 / 15 / 2024, 'D'),
       (NULL, NULL, 'D');

INSERT INTO `VehicleInformation` (vehicleType, description, licensePlate)
VALUES ('D', '1995 BMW SERIES 3', '1BOOMER'),
       ('D', '2022 FORD BRONCO', '0GOPATS0'),
       ('D', '2009 CADILLAC ESCALADE', '2934JVC');


