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
END