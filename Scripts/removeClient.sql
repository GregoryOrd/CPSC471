CREATE DEFINER=`root`@`localhost` PROCEDURE `removeClient`(IN cid int)
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE uid INT;
	DECLARE curs CURSOR FOR
	SELECT dependant.userID
	FROM dependant
	WHERE dependant.client_dependee = cid;
    
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN curs;
    delLoop: LOOP
		FETCH curs INTO uid;
        IF done THEN
			LEAVE delLoop;
		END IF;
        DELETE FROM dependant WHERE userID = uid;
		DELETE FROM user WHERE userID = uid;
	END LOOP;
    CLOSE curs;
    
	DELETE FROM rents WHERE clientID = cid;
	DELETE FROM bill WHERE clientID = cid;
	DELETE FROM request WHERE clientID = cid;
	DELETE FROM credit_card WHERE clientID = cid;
	DELETE FROM client WHERE userID = cid;
	DELETE FROM user WHERE userID = cid;
END