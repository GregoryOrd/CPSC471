USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `listClients`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `listClients`(IN llid int)
BEGIN
	SELECT client.userID
	FROM client
	INNER JOIN rents
	ON client.userID = rents.clientID
	INNER JOIN building
	ON rents.building_name = building.building_name
	WHERE building.landlordID = llid;
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

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `addUser`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `addUser` (IN fName VARCHAR(45), IN lName VARCHAR(45), IN pword VARCHAR(45))
BEGIN
	INSERT INTO user (first_name, last_name, password_hash)
    VALUES (fName, lName, pword);
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `getUserID`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `getUserID` (IN fName VARCHAR(45), IN lName VARCHAR(45), IN pword VARCHAR(45))
BEGIN
	SELECT userID FROM user 
    WHERE first_name = fName AND last_name = lName AND password_hash = pword
    LIMIT 1;
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `addEmployee`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `addEmployee` (IN userID int, IN man_id int, IN hire_date DATE, IN salary double, IN house_num int,
								IN street VARCHAR(45), IN city VARCHAR(45), IN province VARCHAR(45), IN postal VARCHAR(45))
BEGIN
    INSERT INTO employee (userID, hiring_manager, hire_date, salary, house_number, street, city, province, postal_code)
    VALUES (userID, man_id, hire_date, salary, house_num, street, city, province, postal);
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `completeRequest`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `completeRequest` (IN employee_id int, IN request_id int, IN building_name VARCHAR(45),
									IN tool_id int, IN completion_date DATE)
BEGIN
	INSERT INTO service
    VALUES (tool_id, building_name, employee_id, request_id, completion_date);
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `submitRequest`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `submitRequest` (IN client_id int, IN descript VARCHAR(45))
BEGIN
	INSERT INTO request (clientID, description)
    VALUES (client_id, descript);
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `getRequestID`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `getRequestID` (IN client_id int, IN descript VARCHAR(45))
BEGIN
	SELECT requestID
    FROM request
    WHERE request.clientID = client_id AND request.description = descript
    ORDER BY requestID desc
    LIMIT 1;
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `payBill`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `payBill` (IN client_id int, IN bill_id int, IN pay_type VARCHAR(45), IN pay_date DATE)
BEGIN
	UPDATE bill
    SET bill.payment_type = pay_type, bill.payment_date = pay_date
    WHERE bill.clientID = client_id AND bill.billID = bill_id;
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `addClient`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `addClient`(IN uid int, IN regDate datetime, IN contract VARCHAR(45))
BEGIN
	INSERT INTO client
    VALUES (uid, regDate, contract);
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `addDependant`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `addDependant`(IN uid int, IN cid int, IN u18 bool)
BEGIN
	INSERT INTO dependant
    VALUES (uid, cid, u18);
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `getAmenities`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `getAmenities`(IN bname VARCHAR(45))
BEGIN
	SELECT *
	FROM amenity
    WHERE amenity.building_name = bname;
END$$

DELIMITER ;


USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `getApartment`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `getApartment`(IN anum int, IN bname VARCHAR(45))
BEGIN
	SELECT apartment.num_floors, building.city, building.province, building.postal_code, building.street_address
	FROM apartment
	INNER JOIN building
	ON apartment.building_name = building.building_name
    WHERE apartment.apartment_num = anum
	AND apartment.building_name = bname;
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `getApartmentNums`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `getApartmentNums`(IN bname VARCHAR(45))
BEGIN
	SELECT apartment.apartment_num
	FROM apartment
    WHERE apartment.building_name = bname;
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `getBuilding`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `getBuilding`(IN bname VARCHAR(45))
BEGIN
	SELECT *
	FROM building
    WHERE building.building_name = bname;
END$$

DELIMITER ;


USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `getClient`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `getClient`(IN cid VARCHAR(45))
BEGIN
	SELECT user.first_name, user.last_name, client.contract_type, client.registration_date, rents.apartment_num, rents.building_name, rents.start_date, rents.end_date
	FROM client
	INNER JOIN user
	ON client.userID = user.userID
	LEFT JOIN rents
	ON client.userID = rents.clientID
    WHERE client.userID = cid;
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `getDependants`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `getDependants`(IN cid VARCHAR(45))
BEGIN
	SELECT dependant.userID, dependant.is_under_eighteen, user.first_name, user.last_name
	FROM dependant
	INNER JOIN user
	ON dependant.userID = user.userID
    WHERE dependant.client_dependee = cid;
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `getRooms`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `getRooms`(IN anum int, IN bname VARCHAR(45))
BEGIN
	SELECT room.*
	FROM apartment
	INNER JOIN room
	ON apartment.building_name = room.building_name
	AND apartment.apartment_num = room.apartment_num
	WHERE apartment.apartment_num = anum
	AND apartment.building_name = bname;
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `listClientsFiltered`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `listClientsFiltered`(IN llid int, IN bnames VARCHAR(1024))
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
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `removeClient`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `removeClient`(IN cid int)
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
END$$

DELIMITER ;

USE `cpsc471_rental_system`;
DROP procedure IF EXISTS `setRents`;

DELIMITER $$
USE `cpsc471_rental_system`$$
CREATE PROCEDURE `setRents`(IN uid int, IN anum int, IN bname VARCHAR(45), IN sdate date, IN edate date)
BEGIN
	INSERT INTO rents
    VALUES (uid, anum, bname, sdate, edate);
END$$

DELIMITER ;
