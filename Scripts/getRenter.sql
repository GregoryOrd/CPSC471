CREATE DEFINER=`root`@`localhost` PROCEDURE `getRenter`(IN anum int, IN bname VARCHAR(45))
BEGIN
	SELECT clientID
	FROM rents
	WHERE rents.apartment_num = anum
	AND rents.building_name = bname;
END