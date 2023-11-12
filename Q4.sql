--Name:WU WEIXIN
--STUDENT ID: 11311800

-- G4
-- G4 Bill rolls a 2

-- 更新位置
BEGIN TRANSACTION;

-- 1. UPDATE Bill
UPDATE Player
SET CurrentLocation = CurrentLocation + 2,
BankBalance = BankBalance - 400
WHERE PlayerID = 2;

-- 2. UPDATE PROPERTY
UPDATE Properties
SET OwnerID = 2
where PositionID = (select CurrentLocation from Player where PlayerID = 2);


-- 3. UPDATE AuditTrail
INSERT INTO AuditTrail (RecordID,PlayerID, PositionID, BankBalance, GameRound)
VALUES
    (7,(SELECT PlayerID FROM Player WHERE PlayerName = 'Bill'),
    (SELECT CurrentLocation FROM Player WHERE PlayerName = 'Bill'),
    (SELECT BankBalance FROM Player WHERE PlayerName = 'Bill'),
    (SELECT GameRound FROM Player WHERE PlayerName = 'Bill'));


COMMIT;

-- UPDATE Player
-- SET CurrentLocation = CurrentLocation + 2
-- WHERE PlayerID = 2;
--
-- SELECT *
-- FROM Game_View;