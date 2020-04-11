CREATE DEFINER=`root`@`localhost` PROCEDURE `getBuilding`(IN bname VARCHAR(45))
BEGIN
	SELECT *
	FROM building
    WHERE building.building_name = bname;
END