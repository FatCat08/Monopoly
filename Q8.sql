--Name:WU WEIXIN
--STUDENT ID: 11311800

-- G8
-- G8 Bill rolls a 6, and then a 3

-- 更新位置
BEGIN TRANSACTION;

-- 1. UPDATE Bill
UPDATE Player
SET CurrentLocation = (CurrentLocation + 9) % 16,
BankBalance = BankBalance + 200 + 100
WHERE PlayerID = 2;




-- 2. UPDATE AuditTrail
INSERT INTO AuditTrail (RecordID,PlayerID, PositionID, BankBalance, GameRound)
VALUES
    (17,(SELECT PlayerID FROM Player WHERE PlayerName = 'Bill'),
    (SELECT CurrentLocation FROM Player WHERE PlayerName = 'Bill'),
    (SELECT BankBalance FROM Player WHERE PlayerName = 'Bill'),
    (SELECT GameRound FROM Player WHERE PlayerName = 'Bill'));

COMMIT;


-- UPDATE Player
-- -- SET CurrentLocation = (CurrentLocation + 9) % 16
-- set CurrentLocation = 6
-- WHERE PlayerID = 1;
--
-- SELECT *
-- FROM Game_View;