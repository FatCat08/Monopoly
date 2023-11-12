--Name:WU WEIXIN
--STUDENT ID: 11311800

-- Initial Token
INSERT INTO Token (TokenID,TokenName)
VALUES (1,'dog'),
(2,'car'),
(3,'battleship'),
(4,'top hat'),
(5,'thimble'),
(6,'boot');

-- Initial Location
INSERT INTO Location (PositionID,PositionName,PositionType)
VALUES (0,'Pass','Corner'),
(1,'Kilburn','Property'),
(2,'Chance1','Chance'),
(3,'Uni Place','Property'),
(4,'InJail','Corner'),
(5,'Victoria','Property'),
(6,'Community Chest1','Chest'),
(7,'Piccadilly','Property'),
(8,'Free Parking','Corner'),
(9,'Oak House','Property'),
(10,'Chance2','Chance'),
(11,'Owens Park','Property'),
(12,'GO TO JAIL','Corner'),
(13,'AMBS','Property'),
(14,'Community Chest2','Chest'),
(15,'Co-op','Property');

-- Initial Bonus
INSERT INTO Bonus(BonusID, BonusName, Description, PositionID)
VALUES (1,'Pass','Collect £200',0),
(2,'Chance1','Pay each of the other players £50',2),
(3,'InJail','Corner',4),
(4,'Community Chest1','For winning a Beauty Contest, you win £100',6),
(5,'Free Parking','No action',8),
(6,'Chance2','Move forward 3 spaces',10),
(7,'GO TO JAIL','Go to Jail, do not pass GO, do not collect £200',12),
(8,'Community Chest2','Your library books are overdue. Play a fine of £30',14);


-- Initial Properties
INSERT INTO Properties(PropertyID, PropertyName, PurchaseCost, RentCost, Color, OwnerID, PositionID)
VALUES(1,'Kilburn',120,120,'Yellow',NULL,1),
(2,'Uni Place',100,100,'Yellow',1,3),
(3,'Victoria',75,75,'Green',2,5),
(4,'Piccadilly',35,35,'Green',NULL,7),
(5,'Oak House',100,200,'Orange',4,9),
(6,'Owens Park',30,60,'Orange',4,11),
(7,'AMBS',400,400,'Blue',NULL,13),
(8,'Co-op',30,30,'Blue',3,15);


-- INSERT INTO AuditTrail(PLAYERID, POSITIONID, BANKBALANCE, GAMEROUND)
-- VALUES (1,0,500,0),
-- (2,0,500,0),
-- (3,0,500,0),
-- (4,0,500,0);

-- Initial Player
INSERT INTO Player
VALUES (1,'Mary',3,190,8,0,0,1),
(2,'Bill',1,500,11,0,0,1),
(3,'Jane',2,150,13,0,0,1),
(4,'Norman',5,250,1,0,0,1);


INSERT INTO AuditTrail(PLAYERID, POSITIONID, BANKBALANCE, GAMEROUND)
VALUES (1,8,190,0),
(2,11,500,0),
(3,13,150,0),
(4,1,250,0);