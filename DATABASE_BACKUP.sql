-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: cpsc471_rental_system
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `amenity`
--

DROP TABLE IF EXISTS `amenity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amenity` (
  `name` varchar(45) NOT NULL,
  `building_name` varchar(45) NOT NULL,
  `description` varchar(300) DEFAULT NULL,
  `fees` int DEFAULT NULL,
  PRIMARY KEY (`name`,`building_name`),
  KEY `FK_amenity_buildingname` (`building_name`),
  CONSTRAINT `FK_amenity_buildingname` FOREIGN KEY (`building_name`) REFERENCES `building` (`building_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amenity`
--

LOCK TABLES `amenity` WRITE;
/*!40000 ALTER TABLE `amenity` DISABLE KEYS */;
INSERT INTO `amenity` VALUES ('Treadmill Parking Lot','Scranton apartment 1','Features an outdoor array of treadmills for all your exercise needs.',0),('Waterslide & pool','Scranton apartment 2','a chill slide and pool.',5);
/*!40000 ALTER TABLE `amenity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apartment`
--

DROP TABLE IF EXISTS `apartment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apartment` (
  `apartment_num` int NOT NULL,
  `building_name` varchar(45) NOT NULL,
  `num_floors` int DEFAULT NULL,
  PRIMARY KEY (`apartment_num`,`building_name`),
  KEY `FK_apartment_buildingname` (`building_name`),
  CONSTRAINT `FK_apartment_buildingname` FOREIGN KEY (`building_name`) REFERENCES `building` (`building_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apartment`
--

LOCK TABLES `apartment` WRITE;
/*!40000 ALTER TABLE `apartment` DISABLE KEYS */;
INSERT INTO `apartment` VALUES (100,'Scranton apartment 2',1),(101,'Scranton apartment 2',1),(102,'Scranton apartment 2',1),(103,'Scranton apartment 2',1),(200,'Scranton apartment 2',1),(201,'Scranton apartment 2',1),(202,'Scranton apartment 2',1),(203,'Scranton apartment 2',1),(300,'Scranton apartment 2',1),(301,'Scranton apartment 2',1),(420,'Scranton apartment 1',2),(421,'Scranton apartment 1',2),(422,'Scranton apartment 1',2),(423,'Scranton apartment 1',2),(424,'Scranton apartment 1',2),(425,'Scranton apartment 1',2);
/*!40000 ALTER TABLE `apartment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bathroom`
--

DROP TABLE IF EXISTS `bathroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bathroom` (
  `room_num` int NOT NULL,
  `apartment_num` int NOT NULL,
  `building_name` varchar(45) NOT NULL,
  `has_bathtub` bit(1) DEFAULT NULL,
  `has_shower` bit(1) DEFAULT NULL,
  PRIMARY KEY (`room_num`,`apartment_num`,`building_name`),
  KEY `FK_bathroom_apartmentnum` (`apartment_num`),
  KEY `FK_bathroom_buildingname` (`building_name`),
  CONSTRAINT `FK_bathroom_apartmentnum` FOREIGN KEY (`apartment_num`) REFERENCES `room` (`apartment_num`) ON DELETE CASCADE,
  CONSTRAINT `FK_bathroom_buildingname` FOREIGN KEY (`building_name`) REFERENCES `room` (`building_name`) ON DELETE CASCADE,
  CONSTRAINT `FK_bathroom_roomnum` FOREIGN KEY (`room_num`) REFERENCES `room` (`room_num`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bathroom`
--

LOCK TABLES `bathroom` WRITE;
/*!40000 ALTER TABLE `bathroom` DISABLE KEYS */;
INSERT INTO `bathroom` VALUES (4,421,'Scranton apartment 1',_binary '\0',_binary '');
/*!40000 ALTER TABLE `bathroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bedroom`
--

DROP TABLE IF EXISTS `bedroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bedroom` (
  `room_num` int NOT NULL,
  `apartment_num` int NOT NULL,
  `building_name` varchar(45) NOT NULL,
  `num_beds` int DEFAULT NULL,
  PRIMARY KEY (`room_num`,`apartment_num`,`building_name`),
  KEY `FK_bedroom_apartmentnum` (`apartment_num`),
  KEY `FK_bedroom_buildingname` (`building_name`),
  CONSTRAINT `FK_bedroom_apartmentnum` FOREIGN KEY (`apartment_num`) REFERENCES `room` (`apartment_num`) ON DELETE CASCADE,
  CONSTRAINT `FK_bedroom_buildingname` FOREIGN KEY (`building_name`) REFERENCES `room` (`building_name`) ON DELETE CASCADE,
  CONSTRAINT `FK_bedroom_roomnum` FOREIGN KEY (`room_num`) REFERENCES `room` (`room_num`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bedroom`
--

LOCK TABLES `bedroom` WRITE;
/*!40000 ALTER TABLE `bedroom` DISABLE KEYS */;
INSERT INTO `bedroom` VALUES (2,421,'Scranton apartment 1',1);
/*!40000 ALTER TABLE `bedroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill` (
  `clientID` int NOT NULL,
  `billID` int NOT NULL,
  `payment_type` varchar(45) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  PRIMARY KEY (`clientID`,`billID`),
  CONSTRAINT `FK_bill_clientID` FOREIGN KEY (`clientID`) REFERENCES `client` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (5,1,NULL,NULL),(6,2,NULL,NULL);
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `building` (
  `building_name` varchar(45) NOT NULL,
  `landlordID` int DEFAULT NULL,
  `property_manager_id` int DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `province` varchar(45) DEFAULT NULL,
  `postal_code` varchar(45) DEFAULT NULL,
  `street_address` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`building_name`),
  KEY `FK_building_landlordID` (`landlordID`),
  KEY `FK_building_propmngrID` (`property_manager_id`),
  CONSTRAINT `FK_building_landlordID` FOREIGN KEY (`landlordID`) REFERENCES `landlord` (`employeeID`) ON DELETE SET NULL,
  CONSTRAINT `FK_building_propmngrID` FOREIGN KEY (`property_manager_id`) REFERENCES `property_manager` (`employeeID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `building`
--

LOCK TABLES `building` WRITE;
/*!40000 ALTER TABLE `building` DISABLE KEYS */;
INSERT INTO `building` VALUES ('Scranton apartment 1',2,4,'Scranton','Pennsylvania','T4k-0T1','somewhere blvd'),('Scranton apartment 2',2,4,'Scranton','Pennsylvania','T4k-0T2','somewhere else blvd');
/*!40000 ALTER TABLE `building` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `userID` int NOT NULL,
  `registration_date` date DEFAULT NULL,
  `contract_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`userID`),
  CONSTRAINT `FK_userID` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (5,'2015-03-23','2 year'),(6,'2018-11-11','5 years'),(7,'2018-11-11','1 year'),(8,'2018-11-11','3 years'),(9,'2018-11-11','1 year'),(10,'2018-11-11','2 years'),(11,'2010-04-05','6 years'),(12,'2018-11-11','1 year'),(13,'2020-01-04','2 year'),(14,'2014-08-11','1 year'),(15,'2015-12-01','3 years'),(16,'2018-11-11','1 year');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_card`
--

DROP TABLE IF EXISTS `credit_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_card` (
  `clientID` int NOT NULL,
  `card_number` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`clientID`),
  CONSTRAINT `FK_card_clientID` FOREIGN KEY (`clientID`) REFERENCES `client` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_card`
--

LOCK TABLES `credit_card` WRITE;
/*!40000 ALTER TABLE `credit_card` DISABLE KEYS */;
INSERT INTO `credit_card` VALUES (5,'5411168155836494'),(6,'5219319689255354'),(7,'4024007125075241'),(8,'3529926755691708'),(9,'5442331195445477'),(10,'6761580354630235');
/*!40000 ALTER TABLE `credit_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dependant`
--

DROP TABLE IF EXISTS `dependant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dependant` (
  `userID` int NOT NULL,
  `client_dependee` int NOT NULL,
  `is_under_eighteen` bit(1) DEFAULT NULL,
  PRIMARY KEY (`userID`),
  KEY `FK_dep_clientID` (`client_dependee`),
  CONSTRAINT `FK_dep_clientID` FOREIGN KEY (`client_dependee`) REFERENCES `client` (`userID`),
  CONSTRAINT `FK_dep_userID` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependant`
--

LOCK TABLES `dependant` WRITE;
/*!40000 ALTER TABLE `dependant` DISABLE KEYS */;
INSERT INTO `dependant` VALUES (17,15,_binary '\0'),(18,13,_binary '');
/*!40000 ALTER TABLE `dependant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `district_manager`
--

DROP TABLE IF EXISTS `district_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `district_manager` (
  `employeeID` int NOT NULL,
  `district_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`employeeID`),
  CONSTRAINT `FK_dstrctmngr_employeeID` FOREIGN KEY (`employeeID`) REFERENCES `employee` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `district_manager`
--

LOCK TABLES `district_manager` WRITE;
/*!40000 ALTER TABLE `district_manager` DISABLE KEYS */;
INSERT INTO `district_manager` VALUES (1,'Scranton Branch');
/*!40000 ALTER TABLE `district_manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `userID` int NOT NULL,
  `hiring_manager` int DEFAULT NULL,
  `hire_date` date NOT NULL,
  `termination_date` date DEFAULT NULL,
  `salary` int DEFAULT NULL,
  `house_number` int DEFAULT NULL,
  `street` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `province` varchar(45) DEFAULT NULL,
  `postal_code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`userID`),
  KEY `FK_emp_hmngrID` (`hiring_manager`),
  CONSTRAINT `FK_emp_hmngrID` FOREIGN KEY (`hiring_manager`) REFERENCES `district_manager` (`employeeID`) ON DELETE SET NULL,
  CONSTRAINT `FK_emp_userID` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,1,'2009-03-17',NULL,45001,69,'Jan Way','Scranton','Pennsylvania','T4L-Q4L'),(2,NULL,'2010-09-23',NULL,45000,69,'Rose Grove','Scranton','Pennsylvania','T4Lf4L'),(3,1,'2012-09-23',NULL,35000,69,'Spark Wood','Scranton','Pennsylvania','G84-f3L'),(4,1,'2012-09-23',NULL,35000,69,'Spark Wood','Scranton','Pennsylvania','G84-f3L'),(5,1,'2012-09-23',NULL,35000,69,'mennonite beet farm','Scranton','Pennsylvania','G84-f3L');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kitchen`
--

DROP TABLE IF EXISTS `kitchen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kitchen` (
  `room_num` int NOT NULL,
  `apartment_num` int NOT NULL,
  `building_name` varchar(45) NOT NULL,
  `num_sinks` int DEFAULT NULL,
  `counter_top_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`room_num`,`apartment_num`,`building_name`),
  KEY `FK_kitchen_apartmentnum` (`apartment_num`),
  KEY `FK_kitchen_builidingname` (`building_name`),
  CONSTRAINT `FK_kitchen_apartmentnum` FOREIGN KEY (`apartment_num`) REFERENCES `room` (`apartment_num`) ON DELETE CASCADE,
  CONSTRAINT `FK_kitchen_builidingname` FOREIGN KEY (`building_name`) REFERENCES `room` (`building_name`) ON DELETE CASCADE,
  CONSTRAINT `FK_kitchen_room_num` FOREIGN KEY (`room_num`) REFERENCES `room` (`room_num`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kitchen`
--

LOCK TABLES `kitchen` WRITE;
/*!40000 ALTER TABLE `kitchen` DISABLE KEYS */;
INSERT INTO `kitchen` VALUES (3,421,'Scranton apartment 1',1,'15');
/*!40000 ALTER TABLE `kitchen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `landlord`
--

DROP TABLE IF EXISTS `landlord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `landlord` (
  `employeeID` int NOT NULL,
  `region` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`employeeID`),
  CONSTRAINT `FK_landlord_empID` FOREIGN KEY (`employeeID`) REFERENCES `employee` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `landlord`
--

LOCK TABLES `landlord` WRITE;
/*!40000 ALTER TABLE `landlord` DISABLE KEYS */;
INSERT INTO `landlord` VALUES (2,'Scranton Region');
/*!40000 ALTER TABLE `landlord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `living_room`
--

DROP TABLE IF EXISTS `living_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `living_room` (
  `room_num` int NOT NULL,
  `apartment_num` int NOT NULL,
  `building_name` varchar(45) NOT NULL,
  `recommended_tv_size` int DEFAULT NULL,
  PRIMARY KEY (`room_num`,`apartment_num`,`building_name`),
  KEY `FK_livingroom_apartmentnum` (`apartment_num`),
  KEY `FK_livingroom_buildingname` (`building_name`),
  CONSTRAINT `FK_livingroom_apartmentnum` FOREIGN KEY (`apartment_num`) REFERENCES `room` (`apartment_num`) ON DELETE CASCADE,
  CONSTRAINT `FK_livingroom_buildingname` FOREIGN KEY (`building_name`) REFERENCES `room` (`building_name`) ON DELETE CASCADE,
  CONSTRAINT `FK_livingroom_roomnum` FOREIGN KEY (`room_num`) REFERENCES `room` (`room_num`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `living_room`
--

LOCK TABLES `living_room` WRITE;
/*!40000 ALTER TABLE `living_room` DISABLE KEYS */;
INSERT INTO `living_room` VALUES (1,421,'Scranton apartment 1',40);
/*!40000 ALTER TABLE `living_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_manager`
--

DROP TABLE IF EXISTS `property_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property_manager` (
  `employeeID` int NOT NULL,
  `years_experience` int DEFAULT NULL,
  PRIMARY KEY (`employeeID`),
  CONSTRAINT `FK_propmngr_empID` FOREIGN KEY (`employeeID`) REFERENCES `employee` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_manager`
--

LOCK TABLES `property_manager` WRITE;
/*!40000 ALTER TABLE `property_manager` DISABLE KEYS */;
INSERT INTO `property_manager` VALUES (4,2);
/*!40000 ALTER TABLE `property_manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rents`
--

DROP TABLE IF EXISTS `rents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rents` (
  `clientID` int NOT NULL,
  `apartment_num` int NOT NULL,
  `building_name` varchar(45) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  PRIMARY KEY (`clientID`,`apartment_num`,`building_name`),
  KEY `FK_rents_apartmentnum` (`apartment_num`),
  KEY `FK_rents_buildingname` (`building_name`),
  CONSTRAINT `FK_rents_apartmentnum` FOREIGN KEY (`apartment_num`) REFERENCES `apartment` (`apartment_num`) ON DELETE CASCADE,
  CONSTRAINT `FK_rents_buildingname` FOREIGN KEY (`building_name`) REFERENCES `apartment` (`building_name`) ON DELETE CASCADE,
  CONSTRAINT `FK_rents_clientID` FOREIGN KEY (`clientID`) REFERENCES `client` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rents`
--

LOCK TABLES `rents` WRITE;
/*!40000 ALTER TABLE `rents` DISABLE KEYS */;
INSERT INTO `rents` VALUES (5,421,'Scranton apartment 1','2012-09-28','2021-01-01'),(6,420,'Scranton apartment 1','2012-09-28','2021-01-01'),(7,422,'Scranton apartment 1','2012-09-28','2021-01-01'),(8,423,'Scranton apartment 1','2012-09-28','2021-01-01'),(9,424,'Scranton apartment 1','2012-09-28','2021-01-01'),(10,100,'Scranton apartment 2','2012-09-28','2021-01-01'),(11,101,'Scranton apartment 2','2012-09-28','2021-01-01'),(12,102,'Scranton apartment 2','2012-09-28','2021-01-01'),(13,200,'Scranton apartment 2','2012-09-28','2021-01-01'),(14,202,'Scranton apartment 2','2012-09-28','2021-01-01'),(15,300,'Scranton apartment 2','2012-09-28','2021-01-01'),(16,301,'Scranton apartment 2','2012-09-28','2021-01-01');
/*!40000 ALTER TABLE `rents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request`
--

DROP TABLE IF EXISTS `request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `request` (
  `requestID` int NOT NULL AUTO_INCREMENT,
  `clientID` int DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`requestID`),
  KEY `FK_request_clientID` (`clientID`),
  CONSTRAINT `FK_request_clientID` FOREIGN KEY (`clientID`) REFERENCES `client` (`userID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request`
--

LOCK TABLES `request` WRITE;
/*!40000 ALTER TABLE `request` DISABLE KEYS */;
INSERT INTO `request` VALUES (1,13,'Toby was sabotaged with marijuana left inside'),(2,8,'Kevin spilled chili'),(3,10,'Andy needs a new shelf for Cornell stuff');
/*!40000 ALTER TABLE `request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `room_num` int NOT NULL,
  `apartment_num` int NOT NULL,
  `building_name` varchar(45) NOT NULL,
  `num_windows` int DEFAULT NULL,
  `flooring` varchar(45) DEFAULT NULL,
  `room_size` int DEFAULT NULL,
  PRIMARY KEY (`room_num`,`apartment_num`,`building_name`),
  KEY `FK_room_apartmentnum` (`apartment_num`),
  KEY `FK_room_buildingname` (`building_name`),
  CONSTRAINT `FK_room_apartmentnum` FOREIGN KEY (`apartment_num`) REFERENCES `apartment` (`apartment_num`) ON DELETE CASCADE,
  CONSTRAINT `FK_room_buildingname` FOREIGN KEY (`building_name`) REFERENCES `apartment` (`building_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,420,'Scranton apartment 1',1,'Vinyl',400),(1,421,'Scranton apartment 1',2,'Hardwood',500),(1,422,'Scranton apartment 1',2,'Hardwood',600),(2,421,'Scranton apartment 1',0,'Hardwood',500),(3,421,'Scranton apartment 1',1,'Hardwood',500),(4,421,'Scranton apartment 1',1,'Hardwood',200);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `toolID` int NOT NULL,
  `building_name` varchar(45) NOT NULL,
  `technicianID` int NOT NULL,
  `requestID` int NOT NULL,
  `completed_date` date DEFAULT NULL,
  PRIMARY KEY (`building_name`,`toolID`,`technicianID`,`requestID`),
  KEY `FK_service_toolID` (`toolID`),
  KEY `FK_service_technicianID` (`technicianID`),
  KEY `FK_service_requestID` (`requestID`),
  CONSTRAINT `FK_service_buildingname` FOREIGN KEY (`building_name`) REFERENCES `building` (`building_name`),
  CONSTRAINT `FK_service_requestID` FOREIGN KEY (`requestID`) REFERENCES `request` (`requestID`),
  CONSTRAINT `FK_service_technicianID` FOREIGN KEY (`technicianID`) REFERENCES `technician` (`employeeID`),
  CONSTRAINT `FK_service_toolID` FOREIGN KEY (`toolID`) REFERENCES `tool` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (831,'Scranton apartment 1',3,2,'2020-06-25'),(327,'Scranton apartment 2',3,1,'2020-07-04'),(999,'Scranton apartment 2',3,3,'2020-03-01');
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `technician`
--

DROP TABLE IF EXISTS `technician`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `technician` (
  `employeeID` int NOT NULL,
  `speciality` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`employeeID`),
  CONSTRAINT `FK_technician_empID` FOREIGN KEY (`employeeID`) REFERENCES `employee` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `technician`
--

LOCK TABLES `technician` WRITE;
/*!40000 ALTER TABLE `technician` DISABLE KEYS */;
INSERT INTO `technician` VALUES (3,'Secretary skills');
/*!40000 ALTER TABLE `technician` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tool`
--

DROP TABLE IF EXISTS `tool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tool` (
  `id` int NOT NULL,
  `type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tool`
--

LOCK TABLES `tool` WRITE;
/*!40000 ALTER TABLE `tool` DISABLE KEYS */;
INSERT INTO `tool` VALUES (123,'plunger'),(327,'Flex Seal TM'),(583,'SUPER duct tape'),(690,'saw'),(691,'saw 2.0'),(831,'multimeter'),(999,'Matt\'s hangboard');
/*!40000 ALTER TABLE `tool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `password_hash` varchar(45) NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Michael','Scott','dsaf8s9fhasf'),(2,'Jim','Halpert','nzxnvsd0'),(3,'Pam','Beesly','sdf6923obw'),(4,'Dwight','Schrute','dsaf8s9fhasf'),(5,'Angela','Martin','sf9sa6dfa9syf'),(6,'Kelly','Kapoor','sfas8d0f1sc'),(7,'James','Bond','sadf923nd1'),(8,'Kevin','Malone','s-uvs-vjsnd'),(9,'Ryan','Howard','898hgwf'),(10,'Andy','Bernard','mdbf-e0'),(11,'Stanley','Hudson','sfs0r3hp'),(12,'Oscar','Martinez','sdyf2o3t2'),(13,'Toby','Flenderson','ofywtiwf'),(14,'Meredith','Palmer','sfd8uasro3u'),(15,'Phyllis','Vance','s-0dafm'),(16,'Creed','Bratton','sefasf903nslf'),(17,'Bob','Vance, VanceRefrigeration','xf90s8faf'),(18,'Sasha','Flenderson','hf43sf8faf');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'cpsc471_rental_system'
--
/*!50003 DROP PROCEDURE IF EXISTS `addAmenity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addAmenity`(IN bName VARCHAR(45), IN aName VARCHAR(45), IN descrp VARCHAR(45), IN f int, OUT result int)
BEGIN
	INSERT INTO amenity
    VALUES (aName, bName, descrp, f);
    SET result = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addApartment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addApartment`(IN bName VARCHAR(45), IN aNum int, IN nFloors int, OUT result int)
BEGIN
	INSERT INTO apartment
    VALUES (aNum, bName, nFloors);
    SET result = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addBuilding` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addBuilding`(IN bName VARCHAR(45), IN land_id int, IN prop_id int, 
					IN city VARCHAR(45), IN prov VARCHAR(45), IN postal VARCHAR(45), 
					IN street VARCHAR(45), OUT result int)
BEGIN
	INSERT INTO building 
    VALUES (bName, land_id, prop_id, city, prov, postal, street);
    SET result = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addClient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addClient`(IN uid int, IN regDate datetime, IN contract VARCHAR(45))
BEGIN
	INSERT INTO client
    VALUES (uid, regDate, contract);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addDependant` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addDependant`(IN uid int, IN cid int, IN u18 bool)
BEGIN
	INSERT INTO dependant
    VALUES (uid, cid, u18);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addEmployee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addEmployee`(IN userID int, IN man_id int, IN hire_date DATE, IN salary double, IN house_num int,
								IN street VARCHAR(45), IN city VARCHAR(45), IN province VARCHAR(45), IN postal VARCHAR(45))
BEGIN
    INSERT INTO employee (userID, hiring_manager, hire_date, salary, house_number, street, city, province, postal_code)
    VALUES (userID, man_id, hire_date, salary, house_num, street, city, province, postal);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addUser`(IN fName VARCHAR(45), IN lName VARCHAR(45), IN pword VARCHAR(45))
BEGIN
	INSERT INTO user (first_name, last_name, password_hash)
    VALUES (fName, lName, pword);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `completeRequest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `completeRequest`(IN employee_id int, IN request_id int, IN building_name VARCHAR(45),
									IN tool_id int, IN completion_date DATE)
BEGIN
	INSERT INTO service
    VALUES (tool_id, building_name, employee_id, request_id, completion_date);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAmenities` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAmenities`(IN bname VARCHAR(45))
BEGIN
	SELECT *
	FROM amenity
    WHERE amenity.building_name = bname;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getApartment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getApartment`(IN anum int, IN bname VARCHAR(45))
BEGIN
	SELECT apartment.num_floors, building.city, building.province, building.postal_code, building.street_address
	FROM apartment
	INNER JOIN building
	ON apartment.building_name = building.building_name
    WHERE apartment.apartment_num = anum
	AND apartment.building_name = bname;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getApartmentNums` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getApartmentNums`(IN bname VARCHAR(45))
BEGIN
	SELECT apartment.apartment_num
	FROM apartment
    WHERE apartment.building_name = bname;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getBuilding` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getBuilding`(IN bname VARCHAR(45))
BEGIN
	SELECT *
	FROM building
    WHERE building.building_name = bname;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getClient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getClient`(IN cid VARCHAR(45))
BEGIN
	SELECT user.first_name, user.last_name, client.contract_type, client.registration_date, rents.apartment_num, rents.building_name, rents.start_date, rents.end_date
	FROM client
	INNER JOIN user
	ON client.userID = user.userID
	LEFT JOIN rents
	ON client.userID = rents.clientID
    WHERE client.userID = cid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getClients` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getClients`(p_hash VARCHAR(45), u_ID int)
BEGIN
	SELECT *
    FROM client, user
    WHERE client.userID = user.userID
		AND user.userID = u_ID
        AND user.password_hash = p_hash;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getDependants` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getDependants`(IN cid VARCHAR(45))
BEGIN
	SELECT dependant.userID, dependant.is_under_eighteen, user.first_name, user.last_name
	FROM dependant
	INNER JOIN user
	ON dependant.userID = user.userID
    WHERE dependant.client_dependee = cid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getDistrictManagers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getDistrictManagers`(p_hash VARCHAR(45), u_ID int)
BEGIN
	SELECT *
    FROM district_manager, user
    WHERE district_manager.employeeID = user.userID
		AND user.userID = u_ID
        AND user.password_hash = p_hash;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getLandlords` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLandlords`(p_hash VARCHAR(45), u_ID int)
BEGIN
	SELECT *
    FROM landlord, user
    WHERE landlord.employeeID = user.userID
		AND user.userID = u_ID
        AND user.password_hash = p_hash;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPropertyManagers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPropertyManagers`(p_hash VARCHAR(45), u_ID int)
BEGIN
	SELECT *
    FROM property_manager, user
    WHERE property_manager.employeeID = user.userID
		AND user.userID = u_ID
        AND user.password_hash = p_hash;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getRenter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getRenter`(IN anum int, IN bname VARCHAR(45))
BEGIN
	SELECT clientID
	FROM rents
	WHERE rents.apartment_num = anum
	AND rents.building_name = bname;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getRequestID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getRequestID`(IN client_id int, IN descript VARCHAR(45))
BEGIN
	SELECT requestID
    FROM request
    WHERE request.clientID = client_id AND request.description = descript
    ORDER BY requestID desc
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getRooms` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getRooms`(IN anum int, IN bname VARCHAR(45))
BEGIN
	SELECT room.*
	FROM apartment
	INNER JOIN room
	ON apartment.building_name = room.building_name
	AND apartment.apartment_num = room.apartment_num
	WHERE apartment.apartment_num = anum
	AND apartment.building_name = bname;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getTechnicians` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTechnicians`(p_hash VARCHAR(45), u_ID int)
BEGIN
	SELECT *
    FROM technician, user
    WHERE technician.employeeID = user.userID
		AND user.userID = u_ID
        AND user.password_hash = p_hash;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUserID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserID`(IN fName VARCHAR(45), IN lName VARCHAR(45), IN pword VARCHAR(45))
BEGIN
	SELECT userID FROM user 
    WHERE first_name = fName AND last_name = lName AND password_hash = pword
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUsers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUsers`(p_hash VARCHAR(45), u_ID int)
BEGIN
	SELECT * 
    FROM user
    WHERE user.userID = u_ID AND user.password_hash = p_hash;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listClients` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listClients`(IN llid int)
BEGIN
	SELECT client.userID
	FROM client
	INNER JOIN rents
	ON client.userID = rents.clientID
	INNER JOIN building
	ON rents.building_name = building.building_name
	WHERE building.landlordID = llid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listClientsFiltered` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listClientsFiltered`(IN llid int, IN bnames VARCHAR(1024))
BEGIN
	set @q = concat('SELECT client.userID
	FROM client
	INNER JOIN rents
	ON client.userID = rents.clientID
	INNER JOIN building
	ON rents.building_name = building.building_name
	WHERE building.landlordID = ', llid, '
    AND building.building_name IN (', bnames, ')');
    prepare stmt from @q;
    execute stmt;
    deallocate prepare stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `payBill` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `payBill`(IN client_id int, IN bill_id int, IN pay_type VARCHAR(45), IN pay_date DATE)
BEGIN
	UPDATE bill
    SET bill.payment_type = pay_type, bill.payment_date = pay_date
    WHERE bill.clientID = client_id AND bill.billID = bill_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `removeClient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `removeClient`(IN cid int)
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE uid INT;
	DECLARE curs CURSOR FOR
	SELECT dependant.userID
	FROM dependant
	WHERE dependant.client_dependee = cid;
    
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN curs;
    delLoop: LOOP
		FETCH curs INTO uid;
        IF done THEN
			LEAVE delLoop;
		END IF;
        DELETE FROM dependant WHERE userID = uid;
		DELETE FROM user WHERE userID = uid;
	END LOOP;
    CLOSE curs;
    
	DELETE FROM rents WHERE clientID = cid;
	DELETE FROM bill WHERE clientID = cid;
	DELETE FROM request WHERE clientID = cid;
	DELETE FROM credit_card WHERE clientID = cid;
	DELETE FROM client WHERE userID = cid;
	DELETE FROM user WHERE userID = cid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `setRents` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `setRents`(IN uid int, IN anum int, IN bname VARCHAR(45), IN sdate date, IN edate date)
BEGIN
	INSERT INTO rents
    VALUES (uid, anum, bname, sdate, edate);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `submitRequest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `submitRequest`(IN client_id int, IN descript VARCHAR(45))
BEGIN
	INSERT INTO request (clientID, description)
    VALUES (client_id, descript);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updatePassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePassword`(IN p_hash VARCHAR(45), IN u_ID int, OUT result int)
BEGIN
	UPDATE user 
    SET user.password_hash = p_hash
    WHERE user.userID = u_ID;
    SET result = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-14 13:33:17
