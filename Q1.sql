-- G1
-- G1 Jane rolls a 3


-- 更新位置

BEGIN TRANSACTION;
--Name:WU WEIXIN
--STUDENT ID: 11311800

-- 1. UPDATE Jane
UPDATE Player
SET CurrentLocation = (CurrentLocation + 3) % 16,
BankBalance = BankBalance + 200
WHERE PlayerID = 3;

-- 2. UPDATE AuditTrail
INSERT INTO AuditTrail (RecordID,PlayerID, PositionID, BankBalance, GameRound)
VALUES

    (1,(SELECT PlayerID FROM Player WHERE PlayerName = 'Jane'),
    (SELECT CurrentLocation FROM Player WHERE PlayerName = 'Jane'),
    (SELECT BankBalance FROM Player WHERE PlayerName = 'Jane'),
    (SELECT GameRound FROM Player WHERE PlayerName = 'Jane'));

COMMIT;

-- UPDATE Player
-- SET CurrentLocation = 0
-- WHERE PlayerID = 3;
--
-- SELECT *
-- FROM Game_View;