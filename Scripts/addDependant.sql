CREATE DEFINER=`root`@`localhost` PROCEDURE `addDependant`(IN uid int, IN cid int, IN u18 bool)
BEGIN
	INSERT INTO dependant
    VALUES (uid, cid, u18);
END