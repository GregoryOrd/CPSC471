CREATE DEFINER=`root`@`localhost` PROCEDURE `getDependants`(IN cid VARCHAR(45))
BEGIN
	SELECT dependant.userID, dependant.is_under_eighteen, user.first_name, user.last_name
	FROM dependant
	INNER JOIN user
	ON dependant.userID = user.userID
    WHERE dependant.client_dependee = cid;
END