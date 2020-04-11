CREATE DEFINER=`root`@`localhost` PROCEDURE `getAmenities`(IN bname VARCHAR(45))
BEGIN
	SELECT *
	FROM amenity
    WHERE amenity.building_name = bname;
END