CREATE DEFINER=`root`@`localhost` PROCEDURE `listClients`(IN llid int)
BEGIN
	SELECT client.userID
	FROM client
	INNER JOIN rents
	ON client.userID = rents.clientID
	INNER JOIN building
	ON rents.building_name = building.building_name
	WHERE building.landlordID = llid;
END