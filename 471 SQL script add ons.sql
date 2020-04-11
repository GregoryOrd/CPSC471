INSERT INTO `cpsc471_rental_system`.`credit_card` (clientID, card_number) VALUES (005, 5411168155836494);
INSERT INTO `cpsc471_rental_system`.`credit_card` (clientID, card_number) VALUES (006, 5219319689255354);
INSERT INTO `cpsc471_rental_system`.`credit_card` (clientID, card_number) VALUES (007, 4024007125075241);
INSERT INTO `cpsc471_rental_system`.`credit_card` (clientID, card_number) VALUES (008, 3529926755691708);
INSERT INTO `cpsc471_rental_system`.`credit_card` (clientID, card_number) VALUES (009, 5442331195445477);
INSERT INTO `cpsc471_rental_system`.`credit_card` (clientID, card_number) VALUES (010, 6761580354630235);

INSERT INTO `cpsc471_rental_system`.`tool` (id, type) VALUES (690, "saw");
INSERT INTO `cpsc471_rental_system`.`tool` (id, type) VALUES (691, "saw 2.0");
INSERT INTO `cpsc471_rental_system`.`tool` (id, type) VALUES (123, "plunger");
INSERT INTO `cpsc471_rental_system`.`tool` (id, type) VALUES (583, "SUPER duct tape");
INSERT INTO `cpsc471_rental_system`.`tool` (id, type) VALUES (831, "multimeter");
INSERT INTO `cpsc471_rental_system`.`tool` (id, type) VALUES (327, "Flex Seal TM");
INSERT INTO `cpsc471_rental_system`.`tool` (id, type) VALUES (831, "Flex Tape TM"); -- fixes everything 
INSERT INTO `cpsc471_rental_system`.`tool` (id, type) VALUES (999, "Matt's hangboard");

INSERT INTO `cpsc471_rental_system`.`request` (requestID, clientID, description) VALUES (001, 013, "Toby was sabotaged with marijuana left inside" );
INSERT INTO `cpsc471_rental_system`.`request` (requestID, clientID, description) VALUES (002, 008, "Kevin spilled chili");
INSERT INTO `cpsc471_rental_system`.`request` (requestID, clientID, description) VALUES (003, 010, "Andy needs a new shelf for Cornell stuff");

INSERT INTO `cpsc471_rental_system`.`service` (toolID, building_name, technicianID, requestID, completed_date) VALUES (327, "Scranton apartment 2", 003, 001, '2020-07-04');
INSERT INTO `cpsc471_rental_system`.`service` (toolID, building_name, technicianID, requestID, completed_date) VALUES (831, "Scranton apartment 1", 003, 002, '2020-06-25');
INSERT INTO `cpsc471_rental_system`.`service` (toolID, building_name, technicianID, requestID, completed_date) VALUES (999, "Scranton apartment 2", 003, 003, '2020-03-01');
