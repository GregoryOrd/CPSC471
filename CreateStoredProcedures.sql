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

