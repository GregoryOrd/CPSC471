CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserID`(IN fName VARCHAR(45), IN lName VARCHAR(45), IN pword VARCHAR(45))
BEGIN
	SELECT user.userID
    FROM user
    WHERE user.first_name = fName AND user.last_name = lName AND user.password_hash = pword;
END