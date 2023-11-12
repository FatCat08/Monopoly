--Name:WU WEIXIN
--STUDENT ID: 11311800

-- G6
-- G6 Norman rolls a 4

-- 更新位置
BEGIN TRANSACTION;

-- 1. UPDATE Norman
UPDATE Player
SET CurrentLocation = CurrentLocation + 4,
BankBalance = BankBalance + 100
WHERE PlayerID = 4;


-- 2. UPDATE AuditTrail
INSERT INTO AuditTrail (RecordID,PlayerID, PositionID, BankBalance, GameRound)
VALUES
    (14,(SELECT PlayerID FROM Player WHERE PlayerName = 'Norman'),
    (SELECT CurrentLocation FROM Player WHERE PlayerName = 'Norman'),
    (SELECT BankBalance FROM Player WHERE PlayerName = 'Norman'),
    (SELECT GameRound FROM Player WHERE PlayerName = 'Norman'));

COMMIT;

-- UPDATE Player
-- SET CurrentLocation = CurrentLocation + 4
-- WHERE PlayerID = 4;
--
-- SELECT *
-- FROM Game_View;