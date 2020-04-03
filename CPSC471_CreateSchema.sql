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
  `employeedID` INT NOT NULL,
  `district_name` VARCHAR(45) NULL,
  PRIMARY KEY (`employeedID`),
  CONSTRAINT `FK_dstrctmngr_employeeID`
    FOREIGN KEY (`employeedID`)
    REFERENCES `cpsc471_rental_system`.`employee` (`userID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
ALTER TABLE `cpsc471_rental_system`.`employee` 
ADD COLUMN `hiring_manager` INT AFTER `userID`;

ALTER TABLE `cpsc471_rental_system`.`employee` 
ADD CONSTRAINT `FK_emp_hmngrID`
  FOREIGN KEY (`hiring_manager`)
  REFERENCES `cpsc471_rental_system`.`district_manager` (`employeedID`)
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
  `requestID` INT NOT NULL,
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
  `description` VARCHAR(45) NULL,
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
  `roomnum` INT NOT NULL,
  `apartment_num` INT NOT NULL,
  `building_name` VARCHAR(45) NOT NULL,
  `num_sinks` INT NULL,
  `counter_top_type` VARCHAR(45) NULL,
  PRIMARY KEY (`roomnum`, `apartment_num`, `building_name`),
  CONSTRAINT `FK_kitchen_roomnum`
    FOREIGN KEY (`roomnum`)
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