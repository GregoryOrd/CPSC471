CREATE DEFINER=`root`@`localhost` PROCEDURE `getApartmentNums`(IN bname VARCHAR(45))
BEGIN
	SELECT apartment.apartment_num
	FROM apartment
    WHERE apartment.building_name = bname;
END