CREATE DEFINER=`root`@`localhost` PROCEDURE `getApartment`(IN anum int, IN bname VARCHAR(45))
BEGIN
	SELECT apartment.num_floors, building.city, building.province, building.postal_code, building.street_address
	FROM apartment
	INNER JOIN building
	ON apartment.building_name = building.building_name
    WHERE apartment.apartment_num = anum
	AND apartment.building_name = bname;
END