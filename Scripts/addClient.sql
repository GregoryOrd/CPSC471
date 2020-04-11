CREATE DEFINER=`root`@`localhost` PROCEDURE `addClient`(IN uid int, IN regDate datetime, IN contract VARCHAR(45))
BEGIN
	INSERT INTO client
    VALUES (uid, regDate, contract);
END