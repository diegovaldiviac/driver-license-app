DROP DATABASE dlars_db;

CREATE DATABASE dlars_db;
CREATE USER 'webapp'@'%' IDENTIFIED BY 'iker123';
GRANT ALL PRIVILEGES ON dlars_db.* TO'webapp'@'%';
FLUSH PRIVILEGES;

CREATE USER 'sysadmin'@'%' IDENTIFIED BY 'sysadmin789';
CREATE USER 'clerk'@'%' IDENTIFIED BY 'clerk789';
CREATE USER 'user'@'%' IDENTIFIED BY 'user789';


USE dlars_db;

DROP TABLE IF EXISTS `Person`;
CREATE TABLE `Person`
(
    firstName   CHAR(50)        NOT NULL,
    middleName  CHAR(50),
    lastName    CHAR(50)        NOT NULL,
    email       CHAR(50) NOT NULL,
    state       CHAR(4),
    zipCode     INTEGER,
    restriction CHAR(4),
    driversID   INT NOT NULL,
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
    Gender    CHAR(8),
    eyeColor  CHAR(8),
    hairColor Char(8),
    bloodType CHAR(4),
    weight    FLOAT NOT NULL,
    height    FLOAT NOT NULL,
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
    nickname  CHAR(15),
    driversID INT     NOT NULL,
    CONSTRAINT FK4
        FOREIGN KEY (driversID) REFERENCES `Person` (driversID)
    -- FOREIGN KEY driversID INTEGER
);

DROP TABLE IF EXISTS `IncedentHistory`;
CREATE TABLE `IncedentHistory`
(
    -- One of A, B, C, D, E, F
    incidentType CHAR(20) NOT NULL,
    incidentDate DATE    NOT NULL,
    fineAmount   FLOAT   NOT NULL,
    driversID    INT     NOT NULL,
    CONSTRAINT FK5
        FOREIGN KEY (driversID) REFERENCES `Person` (driversID)

);

DROP TABLE IF EXISTS `EmergencyContactInfo`;
CREATE TABLE `EmergencyContactInfo`
(
    firstName   CHAR(25),
    lastName    CHAR(25),
    phoneNumber VARCHAR(50) NOT NULL,
    driversID   INT NOT NULL,
    CONSTRAINT FK6
        FOREIGN KEY (driversID) REFERENCES `Person` (driversID)
);

DROP TABLE IF EXISTS `PreValidationData`;
CREATE TABLE `PreValidationData`
(
    roadTestResult         VARCHAR(10) NOT NULL,
    statusOfLearnersPermit VARCHAR(10) NOT NULL,
    dmvOffice              VARCHAR(20) NOT NULL,
    driversID              INT NOT NULL,
    CONSTRAINT FK7
        FOREIGN KEY (driversID) REFERENCES `Person` (driversID)
);

DROP TABLE IF EXISTS `LicenseAssociatedInformation`;
CREATE TABLE  `LicenseAssociatedInformation`
(
    issueDate      DATE,
    expirationDate DATE,
    VehicleType    CHAR(25) NOT NULL,
    driversID      INT NOT NULL,
    CONSTRAINT FK8
        FOREIGN KEY (driversID) REFERENCES `Person` (driversID)

);

DROP TABLE IF EXISTS `EmergencyConVehicleInformationtactInfo`;
CREATE TABLE `VehicleInformation`
(
    vehicleType  CHAR(25) NOT NULL,
    description  CHAR(50) NOT NULL,
    licensePlate CHAR(20) NOT NULL,
    driversID    INT NOT NULL,
    CONSTRAINT FK9
        FOREIGN KEY (driversID) REFERENCES `Person` (driversID)
);

DROP TABLE IF EXISTS `ClerkInformation`;
CREATE TABLE `ClerkInformation`
(
    firstName  CHAR(50) NOT NULL,
    LastName   CHAR(50) NOT NULL,
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
    NickName   CHAR(50) NOT NULL,
    Password   CHAR(50) NOT NULL,
    EmployeeID INT  NOT NULL,
    CONSTRAINT FK11
        FOREIGN KEY (EmployeeID) REFERENCES `ClerkInformation` (EmployeeID)
);

INSERT INTO `Person` (firstName, middleName, lastName, email, state, zipCode, restriction, driversID) -- These would need a DriversID
VALUES ('Jane', 'Marie', 'Doe', 'j.doe@gmail.com', 'MA', 02111, 'B', 1001),
       ('Joseph', NULL, 'Doe', 'jo.doe@gmail.com', 'MA', 02111, NULL, 1002),
       ('John', NULL, 'Smith', 'johnsmith@company.com', 'MA', 02120, 'B', 1003),
       ('Carlos', NULL, 'Gimeno', 'chupala@company.com', 'MA', 02120, 'B', 1000),
       ('Mauricio','Milton','Castillo','chupalamd@company.com','MA',02115,'B',1004),
       ('Giorgio','Gabriel','Soprano','comepapaya@gmail.com','MA',02111,NULL, 1005),
       ('Leamsi', NULL, 'Zemog', 'leamsizemog@prodigymail.com', 'MA', 02115, NULL, 1006);


INSERT INTO `ClerkInformation`(firstName, LastName, EmployeeID)
VALUES ('Roberto', 'Rodriguez', 10000),
    ('Mariana', 'Guerra', 1100),
    ('Alejandro', 'Rodriguez', 1110),
    ('Gonzalo', 'Estrada', 1111),
    ('Miranda', 'Gonzalez',1112 ),
    ('Hugo', 'Sanchez', 1113);


-- Since as of now, there are no foreign keys that relate all the db, assume that the
INSERT INTO `ApplicationStatus`(LicenseStatus, PendingFirstApproval, EmployeeID)
VALUES ('Approved', 'Pass', 10000),
       ('Approved', 'Fail', 1100),
       ('Rejected', 'Pass', 1110),
       ('Approved', 'Fail', 1111),
       ('Approved', 'Pass', 1112),
       ('Rejected', 'Fail', 1113);
-- We are not sure if the auto increment for the primary key is going to affect
-- the value for the foreign key, therefore it will increase automatically.
-- As of now we will leave it like this, for one erd we will put the, and for the other
-- we are just going to assume that the auto increase will work automatically.
INSERT INTO `AccessCredentials`(NickName, Password, EmployeeID)
VALUES ('Ikandrio', '1239', 10000),
       ('Cabra47', 'holA9', 1100),
       ('Carlosquinto','Rey57', 1110),
       ('Frodo99', 'Gonz123', 1111),
       ('Miranda_99', 'Mir123', 1112),
       ('Huguito','Sanchez65', 1113);


INSERT INTO `Misc` (organDonor, veteran, driversID)
VALUES (TRUE, FALSE, 1000),
       (FALSE, FALSE, 1001),
       (FALSE, TRUE, 1002),
       (FALSE, FALSE, 1003),
       (FALSE,TRUE, 1004),
       (FALSE, TRUE, 1005),
       (TRUE, FALSE, 1006);

-- Used Imperial system (lbs and inches respectively)
-- One of M, F, X (None Binary)
INSERT INTO `BioInformation` (Gender, eyeColor, hairColor, bloodType, weight, height, driversID)
VALUES ('F', 'BROWN', 'BROWN', 'O+', '120', '155', 1000),
       ('M', 'BLUE', 'PINK', 'AB-', '165', '165', 1001),
       ('X', 'BROWN', 'BROW', 'A+', '135', '160', 1002),
       ('X', 'GREEN', 'GREEN', 'B+','300', '140',1004),
       ('X', 'PURPLE', 'SILVER', 'O-','458', '210',1005),
       ('F','BLACK','BROWN', 'A+', '137','173',1003 ),
       ('M', 'HAZEL', 'BLACK', 'O-', '120', '195', 1006);


INSERT INTO `Picture` (pictureAddress, driversID)
VALUES ('3401', 1000),
       ('3402', 1001),
       ('3400', 1003),
       ('3403', 1004),
       ('3404', 1005),
       ('3405', 1006);

INSERT INTO `UserCredential` (password, nickname, driversID)
VALUES (123, 'JMDO', 1000),
       (453, 'JDOE', 1001),
       (3940, 'JOSM', 1002),
       (4567, 'MARIO_NETA', 1004),
       (7543, 'NANITA', 1003),
       (45, 'AVG_LANKE', 1005),
       (8888, 'LEA', 1006);

INSERT INTO  `IncedentHistory` (incidentType, incidentDate, fineAmount, driversID)
VALUES ('DRIVING TICKET', '1989-03-23', 500, 1000),
       ('PARKING TICKET', '2009-09-09', 75, 1001),
       ('DRIVING TICKET', '2012-09-12', 500, 1002),
       ('PARKING TICKET', '2017-11-08', 75, 1004),
       ('PARKING TICKET', '2015-08-29', 75, 1003),
       ('DRIVING TICKET', '2018-03-03', 500, 1005),
       ('PARKING TICKET', '2015-10-11', 75, 1006);

INSERT INTO `EmergencyContactInfo` (firstName, lastName, phoneNumber, driversID)
VALUES ('Joseph', 'Doe', '6172558989', 1000),
       ('Jane', 'Doe', '6172539000', 1001),
       ('Maria', 'Falcao', '3052359898', 1002),
       ('Alagam','Zgom', '1723452891', 1006),
       ('Mike', 'James', '85726543241', 1003),
       ('Janet', 'Rodriguez', '8182801805', 1004),
       ('Mariana', 'Guerra', '8180137200', 1005);

INSERT INTO `PreValidationData` (roadTestResult, statusOfLearnersPermit, dmvOffice, driversID)
VALUES ('PASS', 'CURRENT', 'Watertown', 1000),
       ('PASS', 'CURRENT', 'Springfield', 1001),
       ('FAILED', 'INVALID', 'Haymarket', 1002),
       ('FAILED', 'CURRENT', 'Haymarket', 1003),
       ('PASS', 'CURRENT', 'Springfield', 1004),
       ('PASS', 'CURRENT', 'Haymarket', 1005),
       ('FAILED', 'CURRENT', 'Springfield', 1006);

INSERT INTO   `LicenseAssociatedInformation` (issueDate, expirationDate, vehicleType, driversID)
VALUES ('1969-03-15', '2024-03-15', 'TRUCK', 1000),
       ('1972-03-19', '2027-03-19', 'CAR', 1001),
       ('1969-03-15', '2024-03-15', 'CAR', 1002),
       ('1987-11-27', '2042-11-27', 'Motor Cycle', 1003),
       ('1974-01-01', '2029-01-01', 'TRUCK', 1004),
       ('1978-09-29', '2033-09-29', 'CAR', 1005),
       ('1975-05-21', '2030-05-21', 'Motor Cycle', 1006);

INSERT INTO `VehicleInformation` (vehicleType, description, licensePlate, driversID)
VALUES ('TRUCK', '1995 BMW SERIES 3', '1BOOMER', 1000),
       ('CAR', '2022 FORD BRONCO', '0GOPATS0', 1001),
       ('CAR', '2009 CADILLAC ESCALADE', '2934JVC', 1002),
       ('Motor Cycle', '2007 MERCEDEZ SLK', 'DEREK4', 1003),
       ('TRUCK', 'MACK 2000','BIGDAD',1004),
       ('CAR', 'GM Sport','JSTWN',1005),
       ('Motor Cycle', 'Mitsubishi 1988','LEAMLORD',1006);


