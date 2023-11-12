--Name:WU WEIXIN
--STUDENT ID: 11311800

-- G5
-- G5 Jane rolls a 5


-- 更新位置
BEGIN TRANSACTION;

-- 1. The Second Round, UPDATE Player and AuditTrail
UPDATE Player
SET GameRound = GameRound + 1;

INSERT INTO AuditTrail (RecordID,PlayerID, PositionID, BankBalance, GameRound)
VALUES
    (8,(SELECT PlayerID FROM Player WHERE PlayerName = 'Mary'),
    (SELECT CurrentLocation FROM Player WHERE PlayerName = 'Mary'),
    (SELECT BankBalance FROM Player WHERE PlayerName = 'Mary'),
    (SELECT GameRound FROM Player WHERE PlayerName = 'Mary')),
    (9,(SELECT PlayerID FROM Player WHERE PlayerName = 'Bill'),
    (SELECT CurrentLocation FROM Player WHERE PlayerName = 'Bill'),
    (SELECT BankBalance FROM Player WHERE PlayerName = 'Bill'),
    (SELECT GameRound FROM Player WHERE PlayerName = 'Bill')),
    (10,(SELECT PlayerID FROM Player WHERE PlayerName = 'Jane'),
    (SELECT CurrentLocation FROM Player WHERE PlayerName = 'Jane'),
    (SELECT BankBalance FROM Player WHERE PlayerName = 'Jane'),
    (SELECT GameRound FROM Player WHERE PlayerName = 'Jane')),
    (11,(SELECT PlayerID FROM Player WHERE PlayerName = 'Norman'),
    (SELECT CurrentLocation FROM Player WHERE PlayerName = 'Norman'),
    (SELECT BankBalance FROM Player WHERE PlayerName = 'Norman'),
    (SELECT GameRound FROM Player WHERE PlayerName = 'Norman'));


-- 2. UPDATE Jane
UPDATE Player
SET CurrentLocation = CurrentLocation + 5,
BankBalance = BankBalance - 75
WHERE PlayerID = 3;



-- 3. UPDATE AuditTrail
INSERT INTO AuditTrail (RecordID,PlayerID, PositionID, BankBalance, GameRound)
VALUES
    (12,(SELECT PlayerID FROM Player WHERE PlayerName = 'Jane'),
    (SELECT CurrentLocation FROM Player WHERE PlayerName = 'Jane'),
    (SELECT BankBalance FROM Player WHERE PlayerName = 'Jane'),
    5),
    (13,(SELECT PlayerID FROM Player WHERE PlayerName = 'Bill'),
    (SELECT CurrentLocation FROM Player WHERE PlayerName = 'Bill'),
    (SELECT BankBalance FROM Player WHERE PlayerName = 'Bill'),
    5);


COMMIT;

-- UPDATE Player
-- SET CurrentLocation = CurrentLocation + 5
-- WHERE PlayerID = 3;
--
-- SELECT *
-- FROM Game_View;