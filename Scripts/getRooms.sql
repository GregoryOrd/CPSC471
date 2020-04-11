CREATE DEFINER=`root`@`localhost` PROCEDURE `getRooms`(IN anum int, IN bname VARCHAR(45))
BEGIN
	SELECT room.*
	FROM apartment
	INNER JOIN room
	ON apartment.building_name = room.building_name
	AND apartment.apartment_num = room.apartment_num
	WHERE apartment.apartment_num = anum
	AND apartment.building_name = bname;
END