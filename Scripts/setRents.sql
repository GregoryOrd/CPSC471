CREATE DEFINER=`root`@`localhost` PROCEDURE `setRents`(IN uid int, IN anum int, IN bname VARCHAR(45), IN sdate date, IN edate date)
BEGIN
	INSERT INTO rents
    VALUES (uid, anum, bname, sdate, edate);
END