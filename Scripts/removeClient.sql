CREATE DEFINER=`root`@`localhost` PROCEDURE `removeClient`(IN cid int)
BEGIN
	DELETE FROM dependant WHERE client_dependee = cid;
	DELETE FROM rents WHERE clientID = cid;
	DELETE FROM bill WHERE clientID = cid;
	DELETE FROM request WHERE clientID = cid;
	DELETE FROM credit_card WHERE clientID = cid;
	DELETE FROM client WHERE userID = cid;
	DELETE FROM user WHERE userID = cid;
END