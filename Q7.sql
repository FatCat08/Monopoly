--Name:WU WEIXIN
--STUDENT ID: 11311800

-- G7
-- G7 Mary rolls a 6, and then a 5

-- 更新位置
BEGIN TRANSACTION;

-- 1. UPDATE Mary
UPDATE Player
SET CurrentLocation = CurrentLocation + 5,
BankBalance = BankBalance - 200,
InJail = 0
WHERE PlayerID = 1;

UPDATE Player
SET BankBalance = BankBalance + 200
WHERE PlayerID = 4;


-- 2. UPDATE AuditTrail
INSERT INTO AuditTrail (RecordID,PlayerID, PositionID, BankBalance, GameRound)
VALUES
    (15,(SELECT PlayerID FROM Player WHERE PlayerName = 'Mary'),
    (SELECT CurrentLocation FROM Player WHERE PlayerName = 'Mary'),
    (SELECT BankBalance FROM Player WHERE PlayerName = 'Mary'),
    (SELECT GameRound FROM Player WHERE PlayerName = 'Mary')),
    (16,(SELECT PlayerID FROM Player WHERE PlayerName = 'Norman'),
    (SELECT CurrentLocation FROM Player WHERE PlayerName = 'Norman'),
    (SELECT BankBalance FROM Player WHERE PlayerName = 'Norman'),
    (SELECT GameRound FROM Player WHERE PlayerName = 'Norman'));

COMMIT;
--
-- UPDATE Player
-- SET CurrentLocation = CurrentLocation + 5
-- WHERE PlayerID = 1;
--
-- SELECT *
-- FROM Game_View;