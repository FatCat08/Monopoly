-- G2
-- G2 Norman rolls a 1

-- 更新位置
BEGIN TRANSACTION;

-- 1. UPDATE Norman
UPDATE Player
SET CurrentLocation = (CurrentLocation + 1) % 16,
BankBalance = BankBalance - 150
WHERE PlayerID = 4;

-- 2. UPDATE OTHER 3 Players
UPDATE Player
SET BankBalance = BankBalance + 50
WHERE PlayerID = 1;

UPDATE Player
SET BankBalance = BankBalance + 50
WHERE PlayerID = 2;
--Name:WU WEIXIN
--STUDENT ID: 11311800

UPDATE Player
SET BankBalance = BankBalance + 50
WHERE PlayerID = 3;

-- 3. UPDATE AuditTrail
INSERT INTO AuditTrail (RecordID,PlayerID, PositionID, BankBalance, GameRound)
VALUES
    (2,(SELECT PlayerID FROM Player WHERE PlayerName = 'Mary'),
    (SELECT CurrentLocation FROM Player WHERE PlayerName = 'Mary'),
    (SELECT BankBalance FROM Player WHERE PlayerName = 'Mary'),
    (SELECT GameRound FROM Player WHERE PlayerName = 'Mary')),
    (3,(SELECT PlayerID FROM Player WHERE PlayerName = 'Bill'),
    (SELECT CurrentLocation FROM Player WHERE PlayerName = 'Bill'),
    (SELECT BankBalance FROM Player WHERE PlayerName = 'Bill'),
    (SELECT GameRound FROM Player WHERE PlayerName = 'Bill')),
    (4,(SELECT PlayerID FROM Player WHERE PlayerName = 'Jane'),
    (SELECT CurrentLocation FROM Player WHERE PlayerName = 'Jane'),
    (SELECT BankBalance FROM Player WHERE PlayerName = 'Jane'),
    (SELECT GameRound FROM Player WHERE PlayerName = 'Jane')),
    (5,(SELECT PlayerID FROM Player WHERE PlayerName = 'Norman'),
    (SELECT CurrentLocation FROM Player WHERE PlayerName = 'Norman'),
    (SELECT BankBalance FROM Player WHERE PlayerName = 'Norman'),
    (SELECT GameRound FROM Player WHERE PlayerName = 'Norman'));

COMMIT;
--
-- UPDATE Player
-- SET CurrentLocation = (CurrentLocation + 1) % 16
-- WHERE PlayerID = 4;
--
-- SELECT *
-- FROM Game_View;