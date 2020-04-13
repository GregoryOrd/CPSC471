CREATE SCHEMA `cpsc471_rental_system` ;

CREATE TABLE `cpsc471_rental_system`.`user` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `password_hash` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`userID`));
  
CREATE TABLE `cpsc471_rental_system`.`client` (
  `userID` INT NOT NULL,
  `registration_date` DATE NULL,
  `contract_type` VARCHAR(45) NULL,
  PRIMARY KEY (`userID`),
  CONSTRAINT `FK_userID`
    FOREIGN KEY (`userID`)
    REFERENCES `cpsc471_rental_system`.`user` (`userID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
CREATE TABLE `cpsc471_rental_system`.`dependant` (
  `userID` INT NOT NULL,
  `client_dependee` INT NOT NULL,
  `is_under_eighteen` BIT(1) NULL,
  PRIMARY KEY (`userID`),
  CONSTRAINT `FK_dep_userID`
    FOREIGN KEY (`userID`)
    REFERENCES `cpsc471_rental_system`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_dep_clientID`
    FOREIGN KEY (`client_dependee`)
    REFERENCES `cpsc471_rental_system`.`client` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `cpsc471_rental_system`.`credit_card` (
  `clientID` INT NOT NULL,
  `card_number` VARCHAR(45) NULL,
  PRIMARY KEY (`clientID`),
  CONSTRAINT `FK_card_clientID`
    FOREIGN KEY (`clientID`)
    REFERENCES `cpsc471_rental_system`.`client` (`userID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
/*
Note that due to the relationship between the employee and district manager tables, we must first create the 
employee table without the hiring manager attribute (foreign key). Then we create the district manager table,
and finally alter the employee table to include the hiring manager foreign key pointing to the district manager table.
*/

CREATE TABLE `cpsc471_rental_system`.`employee` (
  `userID` INT NOT NULL,
  `hire_date` DATE NOT NULL,
  `termination_date` DATE NULL,
  `salary` INT NULL,
  `house_number` INT NULL,
  `street` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `province` VARCHAR(45) NULL,
  `postal_code` VARCHAR(45) NULL,
  PRIMARY KEY (`userID`),
  CONSTRAINT `FK_emp_userID`
    FOREIGN KEY (`userID`)
    REFERENCES `cpsc471_rental_system`.`user` (`userID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
        
CREATE TABLE `cpsc471_rental_system`.`district_manager` (
  `employeeID` INT NOT NULL,
  `district_name` VARCHAR(45) NULL,
  PRIMARY KEY (`employeeID`),
  CONSTRAINT `FK_dstrctmngr_employeeID`
    FOREIGN KEY (`employeeID`)
    REFERENCES `cpsc471_rental_system`.`employee` (`userID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
ALTER TABLE `cpsc471_rental_system`.`employee` 
ADD COLUMN `hiring_manager` INT AFTER `userID`;

ALTER TABLE `cpsc471_rental_system`.`employee` 
ADD CONSTRAINT `FK_emp_hmngrID`
  FOREIGN KEY (`hiring_manager`)
  REFERENCES `cpsc471_rental_system`.`district_manager` (`employeeID`)
  ON DELETE SET NULL
  ON UPDATE NO ACTION;
  
CREATE TABLE `cpsc471_rental_system`.`bill` (
  `clientID` INT NOT NULL,
  `billID` INT NOT NULL,
  `payment_type` VARCHAR(45) NULL,
  `payment_date` DATE NULL,
  PRIMARY KEY (`clientID`, `billID`),
  CONSTRAINT `FK_bill_clientID`
    FOREIGN KEY (`clientID`)
    REFERENCES `cpsc471_rental_system`.`client` (`userID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
CREATE TABLE `cpsc471_rental_system`.`request` (
  `requestID` INT NOT NULL AUTO_INCREMENT,
  `clientID` INT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`requestID`),
  CONSTRAINT `FK_request_clientID`
    FOREIGN KEY (`clientID`)
    REFERENCES `cpsc471_rental_system`.`client` (`userID`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION);
    
CREATE TABLE `cpsc471_rental_system`.`technician` (
  `employeeID` INT NOT NULL,
  `speciality` VARCHAR(45) NULL,
  PRIMARY KEY (`employeeID`),
  CONSTRAINT `FK_technician_empID`
    FOREIGN KEY (`employeeID`)
    REFERENCES `cpsc471_rental_system`.`employee` (`userID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
CREATE TABLE `cpsc471_rental_system`.`property_manager` (
  `employeeID` INT NOT NULL,
  `years_experience` INT NULL,
  PRIMARY KEY (`employeeID`),
  CONSTRAINT `FK_propmngr_empID`
    FOREIGN KEY (`employeeID`)
    REFERENCES `cpsc471_rental_system`.`employee` (`userID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
CREATE TABLE `cpsc471_rental_system`.`landlord` (
  `employeeID` INT NOT NULL,
  `region` VARCHAR(45) NULL,
  PRIMARY KEY (`employeeID`),
  CONSTRAINT `FK_landlord_empID`
    FOREIGN KEY (`employeeID`)
    REFERENCES `cpsc471_rental_system`.`employee` (`userID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
CREATE TABLE `cpsc471_rental_system`.`tool` (
  `id` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));
  
CREATE TABLE `cpsc471_rental_system`.`building` (
  `building_name` VARCHAR(45) NOT NULL,
  `landlordID` INT NULL,
  `property_manager_id` INT NULL,
  `city` VARCHAR(45) NULL,
  `province` VARCHAR(45) NULL,
  `postal_code` VARCHAR(45) NULL,
  `street_address` VARCHAR(45) NULL,
  PRIMARY KEY (`building_name`),
  CONSTRAINT `FK_building_landlordID`
    FOREIGN KEY (`landlordID`)
    REFERENCES `cpsc471_rental_system`.`landlord` (`employeeID`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_building_propmngrID`
    FOREIGN KEY (`property_manager_id`)
    REFERENCES `cpsc471_rental_system`.`property_manager` (`employeeID`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION);
    
CREATE TABLE `cpsc471_rental_system`.`amenity` (
  `name` VARCHAR(45) NOT NULL,
  `building_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(300) NULL,
  `fees` INT NULL,
  PRIMARY KEY (`name`, `building_name`),
  CONSTRAINT `FK_amenity_buildingname`
    FOREIGN KEY (`building_name`)
    REFERENCES `cpsc471_rental_system`.`building` (`building_name`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
CREATE TABLE `cpsc471_rental_system`.`service` (
  `toolID` INT NOT NULL,
  `building_name` VARCHAR(45) NOT NULL,
  `technicianID` INT NOT NULL,
  `requestID` INT NOT NULL,
  `completed_date` DATE NULL,
  PRIMARY KEY (`building_name`, `toolID`, `technicianID`, `requestID`),
  CONSTRAINT `FK_service_toolID`
    FOREIGN KEY (`toolID`)
    REFERENCES `cpsc471_rental_system`.`tool` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_service_buildingname`
    FOREIGN KEY (`building_name`)
    REFERENCES `cpsc471_rental_system`.`building` (`building_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_service_technicianID`
    FOREIGN KEY (`technicianID`)
    REFERENCES `cpsc471_rental_system`.`technician` (`employeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_service_requestID`
    FOREIGN KEY (`requestID`)
    REFERENCES `cpsc471_rental_system`.`request` (`requestID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `cpsc471_rental_system`.`apartment` (
  `apartment_num` INT NOT NULL,
  `building_name` VARCHAR(45) NOT NULL,
  `num_floors` INT NULL,
  PRIMARY KEY (`apartment_num`, `building_name`),
  CONSTRAINT `FK_apartment_buildingname`
    FOREIGN KEY (`building_name`)
    REFERENCES `cpsc471_rental_system`.`building` (`building_name`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
CREATE TABLE `cpsc471_rental_system`.`rents` (
  `clientID` INT NOT NULL,
  `apartment_num` INT NOT NULL,
  `building_name` VARCHAR(45) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  PRIMARY KEY (`clientID`, `apartment_num`, `building_name`),
  CONSTRAINT `FK_rents_clientID`
    FOREIGN KEY (`clientID`)
    REFERENCES `cpsc471_rental_system`.`client` (`userID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_rents_apartmentnum`
    FOREIGN KEY (`apartment_num`)
    REFERENCES `cpsc471_rental_system`.`apartment` (`apartment_num`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_rents_buildingname`
    FOREIGN KEY (`building_name`)
    REFERENCES `cpsc471_rental_system`.`apartment` (`building_name`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
CREATE TABLE `cpsc471_rental_system`.`room` (
  `room_num` INT NOT NULL,
  `apartment_num` INT NOT NULL,
  `building_name` VARCHAR(45) NOT NULL,
  `num_windows` INT NULL,
  `flooring` VARCHAR(45) NULL,
  `room_size` INT NULL,
  PRIMARY KEY (`room_num`, `apartment_num`, `building_name`),
  CONSTRAINT `FK_room_apartmentnum`
    FOREIGN KEY (`apartment_num`)
    REFERENCES `cpsc471_rental_system`.`apartment` (`apartment_num`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_room_buildingname`
    FOREIGN KEY (`building_name`)
    REFERENCES `cpsc471_rental_system`.`apartment` (`building_name`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
CREATE TABLE `cpsc471_rental_system`.`bathroom` (
  `room_num` INT NOT NULL,
  `apartment_num` INT NOT NULL,
  `building_name` VARCHAR(45) NOT NULL,
  `has_bathtub` BIT(1) NULL,
  `has_shower` BIT(1) NULL,
  PRIMARY KEY (`room_num`, `apartment_num`, `building_name`),
  CONSTRAINT `FK_bathroom_roomnum`
    FOREIGN KEY (`room_num`)
    REFERENCES `cpsc471_rental_system`.`room` (`room_num`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_bathroom_apartmentnum`
    FOREIGN KEY (`apartment_num`)
    REFERENCES `cpsc471_rental_system`.`room` (`apartment_num`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_bathroom_buildingname`
    FOREIGN KEY (`building_name`)
    REFERENCES `cpsc471_rental_system`.`room` (`building_name`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
CREATE TABLE `cpsc471_rental_system`.`bedroom` (
  `room_num` INT NOT NULL,
  `apartment_num` INT NOT NULL,
  `building_name` VARCHAR(45) NOT NULL,
  `num_beds` INT NULL,
  PRIMARY KEY (`room_num`, `apartment_num`, `building_name`),
  CONSTRAINT `FK_bedroom_roomnum`
    FOREIGN KEY (`room_num`)
    REFERENCES `cpsc471_rental_system`.`room` (`room_num`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_bedroom_apartmentnum`
    FOREIGN KEY (`apartment_num`)
    REFERENCES `cpsc471_rental_system`.`room` (`apartment_num`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_bedroom_buildingname`
    FOREIGN KEY (`building_name`)
    REFERENCES `cpsc471_rental_system`.`room` (`building_name`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
CREATE TABLE `cpsc471_rental_system`.`living_room` (
  `room_num` INT NOT NULL,
  `apartment_num` INT NOT NULL,
  `building_name` VARCHAR(45) NOT NULL,
  `recommended_tv_size` INT NULL,
  PRIMARY KEY (`room_num`, `apartment_num`, `building_name`),
  CONSTRAINT `FK_livingroom_roomnum`
    FOREIGN KEY (`room_num`)
    REFERENCES `cpsc471_rental_system`.`room` (`room_num`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_livingroom_apartmentnum`
    FOREIGN KEY (`apartment_num`)
    REFERENCES `cpsc471_rental_system`.`room` (`apartment_num`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_livingroom_buildingname`
    FOREIGN KEY (`building_name`)
    REFERENCES `cpsc471_rental_system`.`room` (`building_name`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
CREATE TABLE `cpsc471_rental_system`.`kitchen` (
  `room_num` INT NOT NULL,
  `apartment_num` INT NOT NULL,
  `building_name` VARCHAR(45) NOT NULL,
  `num_sinks` INT NULL,
  `counter_top_type` VARCHAR(45) NULL,
  PRIMARY KEY (`room_num`, `apartment_num`, `building_name`),
  CONSTRAINT `FK_kitchen_room_num`
    FOREIGN KEY (`room_num`)
    REFERENCES `cpsc471_rental_system`.`room` (`room_num`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_kitchen_apartmentnum`
    FOREIGN KEY (`apartment_num`)
    REFERENCES `cpsc471_rental_system`.`room` (`apartment_num`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_kitchen_builidingname`
    FOREIGN KEY (`building_name`)
    REFERENCES `cpsc471_rental_system`.`room` (`building_name`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
    
-- DATA INPUT    
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (001, 'Michael', 'Scott', 'dsaf8s9fhasf');
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (002, 'Halpert', 'Jim', 'nzxnvsd0');
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (003, 'Beesly', 'Pam', 'sdf6923obw');
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (004, 'Schrute', 'Dwight', 'dsaf8s9fhasf');
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (005, 'Martin', 'Angela', 'sf9sa6dfa9syf');
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (006, 'Kapoor', 'Kelly', 'sfas8d0f1sc');
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (007, 'Bond', 'James', 'sadf923nd1');
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (008, 'Malone', 'Kevin', 's-uvs-vjsnd');
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (009, 'Howard', 'Ryan', '898hgwf');
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (010, 'Bernard', 'Andy', 'mdbf-e0');
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (011, 'Hudson', 'Stanley', 'sfs0r3hp');
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (012, 'Martinez', 'Oscar', 'sdyf2o3t2');
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (013, 'Flenderson', 'Toby', 'ofywtiwf');
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (014, 'Palmer', 'Meredith', 'sfd8uasro3u');
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (015, 'Vance', 'Phyllis', 's-0dafm');
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (016, 'Bratton', 'Creed', 'sefasf903nslf');
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (017, 'Vance, Vance Refrigeration', 'Bob', 'xf90s8faf');
INSERT INTO `cpsc471_rental_system`.`user` (userId, first_name, last_name, password_hash) VALUES (018, 'Flenderson', 'Sasha', 'hf43sf8faf');

INSERT INTO `cpsc471_rental_system`.`client` (userId, registration_date, contract_type ) VALUES (005, '2015-03-23', '2 year');  
INSERT INTO `cpsc471_rental_system`.`client` (userId, registration_date, contract_type ) VALUES (006, '2018-11-11', '5 years');  
INSERT INTO `cpsc471_rental_system`.`client` (userId, registration_date, contract_type ) VALUES (007, '2018-11-11', '1 year');  
INSERT INTO `cpsc471_rental_system`.`client` (userId, registration_date, contract_type ) VALUES (008, '2018-11-11', '3 years');  
INSERT INTO `cpsc471_rental_system`.`client` (userId, registration_date, contract_type ) VALUES (009, '2018-11-11', '1 year');  
INSERT INTO `cpsc471_rental_system`.`client` (userId, registration_date, contract_type ) VALUES (010, '2018-11-11', '2 years');  
INSERT INTO `cpsc471_rental_system`.`client` (userId, registration_date, contract_type ) VALUES (011, '2010-04-05', '6 years');  
INSERT INTO `cpsc471_rental_system`.`client` (userId, registration_date, contract_type ) VALUES (012, '2018-11-11', '1 year');  
INSERT INTO `cpsc471_rental_system`.`client` (userId, registration_date, contract_type ) VALUES (013, '2020-01-04', '2 year');  
INSERT INTO `cpsc471_rental_system`.`client` (userId, registration_date, contract_type ) VALUES (014, '2014-08-11', '1 year');
INSERT INTO `cpsc471_rental_system`.`client` (userId, registration_date, contract_type ) VALUES (015, '2015-12-01', '3 years');    
INSERT INTO `cpsc471_rental_system`.`client` (userId, registration_date, contract_type ) VALUES (016, '2018-11-11', '1 year');  

INSERT INTO `cpsc471_rental_system`.`dependant` (userId, client_dependee, is_under_eighteen) VALUES (17, 15, False); -- Phyllis's husband
INSERT INTO `cpsc471_rental_system`.`dependant` (userId, client_dependee, is_under_eighteen) VALUES (18, 13, True); -- Toby's daughter

INSERT INTO `cpsc471_rental_system`.`employee` (userId, hiring_manager, hire_date, termination_date, salary, house_number, street, city, province, postal_code) VALUES (001, null, '2009-03-17', null, 45001, 69, "Jan Way", "Scranton", "Pennsylvania", "T4L-Q4L");
INSERT INTO `cpsc471_rental_system`.`district_manager` (employeeID, district_name) VALUES (001, "Scranton Branch"); -- make Michael Scott district manager

INSERT INTO `cpsc471_rental_system`.`employee` (userId, hiring_manager, hire_date, termination_date, salary, house_number, street, city, province, postal_code) VALUES (002, null, '2010-09-23', null, 45000, 69, "Rose Grove", "Scranton", "Pennsylvania", "T4Lf4L");
INSERT INTO `cpsc471_rental_system`.`employee` (userId, hiring_manager, hire_date, termination_date, salary, house_number, street, city, province, postal_code) VALUES (003, 001, '2012-09-23', null, 35000, 69, "Spark Wood", "Scranton", "Pennsylvania", "G84-f3L");
INSERT INTO `cpsc471_rental_system`.`employee` (userId, hiring_manager, hire_date, termination_date, salary, house_number, street, city, province, postal_code) VALUES (004, 001, '2012-09-23', null, 35000, 69, "Spark Wood", "Scranton", "Pennsylvania", "G84-f3L");
INSERT INTO `cpsc471_rental_system`.`employee` (userId, hiring_manager, hire_date, termination_date, salary, house_number, street, city, province, postal_code) VALUES (005, 001, '2012-09-23', null, 35000, 69, "mennonite beet farm", "Scranton", "Pennsylvania", "G84-f3L");

UPDATE `cpsc471_rental_system`.`employee`
SET hiring_manager = 001 
WHERE userId = 001; -- set michael scott's hiring manager as himself(?)

INSERT INTO `cpsc471_rental_system`.`landlord` (employeeID, region) VALUES (002, "Scranton Region"); 

INSERT INTO `cpsc471_rental_system`.`technician` (employeeID, speciality) VALUES (003, "Secretary skills"); 

INSERT INTO `cpsc471_rental_system`.`property_manager` (employeeID, years_experience) VALUES (004, 2);  

INSERT INTO `cpsc471_rental_system`.`building` (building_name, landlordID, property_manager_id, city, province, postal_code, street_address) VALUES ("Scranton apartment 1", 002, 004, "Scranton", "Pennsylvania", "T4k-0T1", "somewhere blvd");
INSERT INTO `cpsc471_rental_system`.`building` (building_name, landlordID, property_manager_id, city, province, postal_code, street_address) VALUES ("Scranton apartment 2", 002, 004, "Scranton", "Pennsylvania", "T4k-0T2", "somewhere else blvd");

INSERT INTO `cpsc471_rental_system`.`amenity` (name, building_name, description, fees) VALUES ("Treadmill Parking Lot", "Scranton apartment 1", "Features an outdoor array of treadmills for all your exercise needs.", 0);
INSERT INTO `cpsc471_rental_system`.`amenity` (name, building_name, description, fees) VALUES ("Waterslide & pool", "Scranton apartment 2", "a chill slide and pool.", 5);

INSERT INTO `cpsc471_rental_system`.`apartment` (apartment_num, building_name, num_floors) VALUES (420, "Scranton apartment 1", 2);
INSERT INTO `cpsc471_rental_system`.`apartment` (apartment_num, building_name, num_floors) VALUES (421, "Scranton apartment 1", 2);
INSERT INTO `cpsc471_rental_system`.`apartment` (apartment_num, building_name, num_floors) VALUES (422, "Scranton apartment 1", 2);
INSERT INTO `cpsc471_rental_system`.`apartment` (apartment_num, building_name, num_floors) VALUES (423, "Scranton apartment 1", 2);
INSERT INTO `cpsc471_rental_system`.`apartment` (apartment_num, building_name, num_floors) VALUES (424, "Scranton apartment 1", 2);
INSERT INTO `cpsc471_rental_system`.`apartment` (apartment_num, building_name, num_floors) VALUES (425, "Scranton apartment 1", 2);
INSERT INTO `cpsc471_rental_system`.`apartment` (apartment_num, building_name, num_floors) VALUES (100, "Scranton apartment 2", 1);
INSERT INTO `cpsc471_rental_system`.`apartment` (apartment_num, building_name, num_floors) VALUES (101, "Scranton apartment 2", 1);
INSERT INTO `cpsc471_rental_system`.`apartment` (apartment_num, building_name, num_floors) VALUES (102, "Scranton apartment 2", 1);
INSERT INTO `cpsc471_rental_system`.`apartment` (apartment_num, building_name, num_floors) VALUES (103, "Scranton apartment 2", 1);
INSERT INTO `cpsc471_rental_system`.`apartment` (apartment_num, building_name, num_floors) VALUES (200, "Scranton apartment 2", 1);
INSERT INTO `cpsc471_rental_system`.`apartment` (apartment_num, building_name, num_floors) VALUES (201, "Scranton apartment 2", 1);
INSERT INTO `cpsc471_rental_system`.`apartment` (apartment_num, building_name, num_floors) VALUES (202, "Scranton apartment 2", 1);
INSERT INTO `cpsc471_rental_system`.`apartment` (apartment_num, building_name, num_floors) VALUES (203, "Scranton apartment 2", 1);
INSERT INTO `cpsc471_rental_system`.`apartment` (apartment_num, building_name, num_floors) VALUES (300, "Scranton apartment 2", 1);
INSERT INTO `cpsc471_rental_system`.`apartment` (apartment_num, building_name, num_floors) VALUES (301, "Scranton apartment 2", 1);

INSERT INTO `cpsc471_rental_system`.`rents` (clientID, apartment_num, building_name, start_date, end_date) VALUES (005, 421, "Scranton apartment 1", '2012-09-28', '2021-01-01');
INSERT INTO `cpsc471_rental_system`.`rents` (clientID, apartment_num, building_name, start_date, end_date) VALUES (006, 420, "Scranton apartment 1", '2012-09-28', '2021-01-01');
INSERT INTO `cpsc471_rental_system`.`rents` (clientID, apartment_num, building_name, start_date, end_date) VALUES (007, 422, "Scranton apartment 1", '2012-09-28', '2021-01-01');
INSERT INTO `cpsc471_rental_system`.`rents` (clientID, apartment_num, building_name, start_date, end_date) VALUES (008, 423, "Scranton apartment 1", '2012-09-28', '2021-01-01');
INSERT INTO `cpsc471_rental_system`.`rents` (clientID, apartment_num, building_name, start_date, end_date) VALUES (009, 424, "Scranton apartment 1", '2012-09-28', '2021-01-01');
INSERT INTO `cpsc471_rental_system`.`rents` (clientID, apartment_num, building_name, start_date, end_date) VALUES (010, 100, "Scranton apartment 2", '2012-09-28', '2021-01-01');
INSERT INTO `cpsc471_rental_system`.`rents` (clientID, apartment_num, building_name, start_date, end_date) VALUES (011, 101, "Scranton apartment 2", '2012-09-28', '2021-01-01');
INSERT INTO `cpsc471_rental_system`.`rents` (clientID, apartment_num, building_name, start_date, end_date) VALUES (012, 102, "Scranton apartment 2", '2012-09-28', '2021-01-01');
INSERT INTO `cpsc471_rental_system`.`rents` (clientID, apartment_num, building_name, start_date, end_date) VALUES (013, 200, "Scranton apartment 2", '2012-09-28', '2021-01-01');
INSERT INTO `cpsc471_rental_system`.`rents` (clientID, apartment_num, building_name, start_date, end_date) VALUES (014, 202, "Scranton apartment 2", '2012-09-28', '2021-01-01');
INSERT INTO `cpsc471_rental_system`.`rents` (clientID, apartment_num, building_name, start_date, end_date) VALUES (015, 300, "Scranton apartment 2", '2012-09-28', '2021-01-01');
INSERT INTO `cpsc471_rental_system`.`rents` (clientID, apartment_num, building_name, start_date, end_date) VALUES (016, 301, "Scranton apartment 2", '2012-09-28', '2021-01-01');

INSERT INTO `cpsc471_rental_system`.`room` (room_num, apartment_num, building_name, num_windows, flooring, room_size) VALUES (01, 421, "Scranton apartment 1", 2, "Hardwood", 500);
INSERT INTO `cpsc471_rental_system`.`room` (room_num, apartment_num, building_name, num_windows, flooring, room_size) VALUES (02, 421, "Scranton apartment 1", 0, "Hardwood", 500);
INSERT INTO `cpsc471_rental_system`.`room` (room_num, apartment_num, building_name, num_windows, flooring, room_size) VALUES (03, 421, "Scranton apartment 1", 1, "Hardwood", 500);
INSERT INTO `cpsc471_rental_system`.`room` (room_num, apartment_num, building_name, num_windows, flooring, room_size) VALUES (04, 421, "Scranton apartment 1", 1, "Hardwood", 200);
INSERT INTO `cpsc471_rental_system`.`room` (room_num, apartment_num, building_name, num_windows, flooring, room_size) VALUES (01, 420, "Scranton apartment 1", 1, "Vinyl", 400);
INSERT INTO `cpsc471_rental_system`.`room` (room_num, apartment_num, building_name, num_windows, flooring, room_size) VALUES (01, 422, "Scranton apartment 1", 2, "Hardwood", 600);
 
INSERT INTO `cpsc471_rental_system`.`living_room` (room_num, apartment_num, building_name, recommended_tv_size) VALUES (01, 421, "Scranton apartment 1", 40);
INSERT INTO `cpsc471_rental_system`.`bedroom` (room_num, apartment_num, building_name, num_beds) VALUES (02, 421, "Scranton apartment 1", 1);
INSERT INTO `cpsc471_rental_system`.`kitchen` (room_num, apartment_num, building_name, num_sinks, counter_top_type) VALUES (03, 421, "Scranton apartment 1", 1, 15);
INSERT INTO `cpsc471_rental_system`.`bathroom` (room_num, apartment_num, building_name, has_bathtub, has_shower) VALUES (04, 421, "Scranton apartment 1", False, True); -- user 005 only has 4 fleshed out rooms for now 

INSERT INTO `cpsc471_rental_system`.`credit_card` (clientID, card_number) VALUES (005, 5411168155836494);
INSERT INTO `cpsc471_rental_system`.`credit_card` (clientID, card_number) VALUES (006, 5219319689255354);
INSERT INTO `cpsc471_rental_system`.`credit_card` (clientID, card_number) VALUES (007, 4024007125075241);
INSERT INTO `cpsc471_rental_system`.`credit_card` (clientID, card_number) VALUES (008, 3529926755691708);
INSERT INTO `cpsc471_rental_system`.`credit_card` (clientID, card_number) VALUES (009, 5442331195445477);
INSERT INTO `cpsc471_rental_system`.`credit_card` (clientID, card_number) VALUES (010, 6761580354630235);

INSERT INTO `cpsc471_rental_system`.`tool` (id, type) VALUES (690, "saw");
INSERT INTO `cpsc471_rental_system`.`tool` (id, type) VALUES (691, "saw 2.0");
INSERT INTO `cpsc471_rental_system`.`tool` (id, type) VALUES (123, "plunger");
INSERT INTO `cpsc471_rental_system`.`tool` (id, type) VALUES (583, "SUPER duct tape");
INSERT INTO `cpsc471_rental_system`.`tool` (id, type) VALUES (831, "multimeter");
INSERT INTO `cpsc471_rental_system`.`tool` (id, type) VALUES (327, "Flex Seal TM");
-- INSERT INTO `cpsc471_rental_system`.`tool` (id, type) VALUES (831, "Flex Tape TM"); -- fixes everything 
INSERT INTO `cpsc471_rental_system`.`tool` (id, type) VALUES (999, "Matt's hangboard");

INSERT INTO `cpsc471_rental_system`.`request` (requestID, clientID, description) VALUES (001, 013, "Toby was sabotaged with marijuana left inside" );
INSERT INTO `cpsc471_rental_system`.`request` (requestID, clientID, description) VALUES (002, 008, "Kevin spilled chili");
INSERT INTO `cpsc471_rental_system`.`request` (requestID, clientID, description) VALUES (003, 010, "Andy needs a new shelf for Cornell stuff");

INSERT INTO `cpsc471_rental_system`.`service` (toolID, building_name, technicianID, requestID, completed_date) VALUES (327, "Scranton apartment 2", 003, 001, '2020-07-04');
INSERT INTO `cpsc471_rental_system`.`service` (toolID, building_name, technicianID, requestID, completed_date) VALUES (831, "Scranton apartment 1", 003, 002, '2020-06-25');
INSERT INTO `cpsc471_rental_system`.`service` (toolID, building_name, technicianID, requestID, completed_date) VALUES (999, "Scranton apartment 2", 003, 003, '2020-03-01');
