USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `listClients`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `listClients` ()
BEGIN
	SELECT * FROM CLIENT;
END$$

DELIMITER ;

DROP procedure IF EXISTS `getUsers`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `getUsers` (p_hash VARCHAR(45), u_ID int) 
BEGIN
	SELECT * 
    FROM user
    WHERE user.userID = u_ID AND user.password_hash = p_hash;
END$$

DELIMITER ;

DROP procedure IF EXISTS `getPropertyManagers`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `getPropertyManagers` (p_hash VARCHAR(45), u_ID int)
BEGIN
	SELECT *
    FROM property_manager, user
    WHERE property_manager.employeeID = user.userID
		AND user.userID = u_ID
        AND user.password_hash = p_hash;
END$$

DELIMITER ;

DROP procedure IF EXISTS `getDistrictManagers`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `getDistrictManagers` (p_hash VARCHAR(45), u_ID int)
BEGIN
	SELECT *
    FROM district_manager, user
    WHERE district_manager.employeeID = user.userID
		AND user.userID = u_ID
        AND user.password_hash = p_hash;
END$$

DELIMITER ;

DROP procedure IF EXISTS `getTechnicians`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `getTechnicians` (p_hash VARCHAR(45), u_ID int)
BEGIN
	SELECT *
    FROM technician, user
    WHERE technician.employeeID = user.userID
		AND user.userID = u_ID
        AND user.password_hash = p_hash;
END$$

DELIMITER ;

DROP procedure IF EXISTS `getLandlords`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `getLandlords` (p_hash VARCHAR(45), u_ID int)
BEGIN
	SELECT *
    FROM landlord, user
    WHERE landlord.employeeID = user.userID
		AND user.userID = u_ID
        AND user.password_hash = p_hash;
END$$

DELIMITER ;

DROP procedure IF EXISTS `getClients`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `getClients` (p_hash VARCHAR(45), u_ID int)
BEGIN
	SELECT *
    FROM client, user
    WHERE client.userID = user.userID
		AND user.userID = u_ID
        AND user.password_hash = p_hash;
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `updatePassword`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `updatePassword` (IN p_hash VARCHAR(45), IN u_ID int, OUT result int)
BEGIN
	UPDATE user 
    SET user.password_hash = p_hash
    WHERE user.userID = u_ID;
    SET result = 1;
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `addBuilding`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `addBuilding` (IN bName VARCHAR(45), IN land_id int, IN prop_id int, 
					IN city VARCHAR(45), IN prov VARCHAR(45), IN postal VARCHAR(45), 
					IN street VARCHAR(45), OUT result int)
BEGIN
	INSERT INTO building 
    VALUES (bName, land_id, prop_id, city, prov, postal, street);
    SET result = 1;
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `addApartment`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `addApartment` (IN bName VARCHAR(45), IN aNum int, IN nFloors int, OUT result int)
BEGIN
	INSERT INTO apartment
    VALUES (aNum, bName, nFloors);
    SET result = 1;
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `addAmenity`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `addAmenity` (IN bName VARCHAR(45), IN aName VARCHAR(45), IN descrp VARCHAR(45), IN f int, OUT result int)
BEGIN
	INSERT INTO amenity
    VALUES (aName, bName, descrp, f);
    SET result = 1;
END$$

DELIMITER ;

