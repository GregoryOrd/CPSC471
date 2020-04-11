CREATE DEFINER=`root`@`localhost` PROCEDURE `getClient`(IN cid VARCHAR(45))
BEGIN
	SELECT user.first_name, user.last_name, client.contract_type, client.registration_date, rents.apartment_num, rents.building_name, rents.start_date, rents.end_date
	FROM client
	INNER JOIN user
	ON client.userID = user.userID
	LEFT JOIN rents
	ON client.userID = rents.clientID
    WHERE client.userID = cid;
END