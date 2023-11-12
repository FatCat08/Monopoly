-- G3
-- G3 Mary rolls a 4
--Name:WU WEIXIN
--STUDENT ID: 11311800


-- 更新位置
BEGIN TRANSACTION;

-- 1. UPDATE Mary
UPDATE Player
SET CurrentLocation = 4,
InJail = 1
WHERE PlayerID = 1;



-- 2. UPDATE AuditTrail
INSERT INTO AuditTrail (RecordID,PlayerID, PositionID, BankBalance, GameRound)
VALUES
    (6,(SELECT PlayerID FROM Player WHERE PlayerName = 'Mary'),
    (SELECT CurrentLocation FROM Player WHERE PlayerName = 'Mary'),
    (SELECT BankBalance FROM Player WHERE PlayerName = 'Mary'),
    (SELECT GameRound FROM Player WHERE PlayerName = 'Mary'));


COMMIT;

-- UPDATE Player
-- SET CurrentLocation = 12
-- WHERE PlayerID = 1;
--
-- SELECT *
-- FROM Game_View;