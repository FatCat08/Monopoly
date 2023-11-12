
----Name:WU WEIXIN
--STUDENT ID: 11311800


-- 1. Pass "Pass", player add 200
CREATE TRIGGER Pass_TRI
BEFORE UPDATE OF CurrentLocation ON Player
FOR EACH ROW
WHEN (NEW.CurrentLocation < OLD.CurrentLocation) AND (NEW.CurrentLocation != 4)
BEGIN
    UPDATE Player
    SET BankBalance = new.BankBalance + 200
    where PlayerID = new.PlayerID;
end;

-- 2.pass different properties
Drop TRIGGER IF EXISTS Property_Arrive;
-- 2.1 pass the property that have owner
CREATE TRIGGER Property_Arrive
AFTER UPDATE OF CurrentLocation ON Player
FOR EACH ROW
WHEN ((NEW.CurrentLocation IN (1,3,5,7,9,11,13,15) AND (SELECT OwnerID FROM Properties WHERE PositionID = NEW.CurrentLocation) IS NOT NULL))
BEGIN
    -- If the player is not the owener，pay the rent
    UPDATE Player
    SET BankBalance = BankBalance -
        (CASE
            WHEN NEW.PlayerID != (SELECT OwnerID FROM Properties WHERE PositionID = NEW.CurrentLocation)
                THEN (SELECT RentCost FROM Properties WHERE PositionID = NEW.CurrentLocation)
            ELSE 0
        END)
    WHERE PlayerID = NEW.PlayerID;
    -- Add money to the owner
    UPDATE Player
    SET BankBalance = BankBalance +
        (CASE
            WHEN NEW.PlayerID != (SELECT OwnerID FROM Properties WHERE PositionID = NEW.CurrentLocation)
                THEN (SELECT RentCost FROM Properties WHERE PositionID = NEW.CurrentLocation)
            ELSE 0
        END)
    WHERE PlayerID = (SELECT OwnerID FROM Properties WHERE PositionID = NEW.CurrentLocation);

END;

-- 2.2 pass the properties that don't have owner
Drop TRIGGER IF EXISTS Property_Arrive_1;
CREATE TRIGGER Property_Arrive_1
AFTER UPDATE OF CurrentLocation ON Player
FOR EACH ROW
WHEN ((NEW.CurrentLocation IN (1,3,5,7,9,11,13,15) AND (SELECT OwnerID FROM Properties WHERE PositionID = NEW.CurrentLocation) IS NULL)) AND (NEW.BankBalance >= (SELECT RentCost FROM Properties WHERE PositionID = NEW.CurrentLocation))
BEGIN
    -- Buy the property
    UPDATE Player
    SET BankBalance = BankBalance - (SELECT PurchaseCost FROM Properties WHERE PositionID = NEW.CurrentLocation)
    WHERE PlayerID = NEW.PlayerID;

    -- update the property table
    UPDATE Properties
    SET OwnerID = NEW.PlayerID
    WHERE PositionID = New.CurrentLocation;

    -- Check whether have the same color property
    UPDATE Properties
    SET RentCost = PurchaseCost * 2
    Where OwnerID = new.PlayerID
    AND (select count(*) from Properties where PositionID = New.CurrentLocation and Color = (select Color from Properties where PositionID = new.CurrentLocation)) = 2;
END;

-- 2.3 Pass Chance1
CREATE TRIGGER Chance1_Arrive
AFTER UPDATE OF CurrentLocation ON Player
FOR EACH ROW
WHEN new.CurrentLocation = 2
BEGIN
    UPDATE Player
    SET BankBalance = BankBalance - 50 * ((select count(*) from Player)-1)
    WHERE PlayerID = NEW.PlayerID;

    UPDATE Player
    SET BankBalance = BankBalance + 50
    WHERE PlayerID != new.PlayerID;
END;

-- 2.4 pass Chance2
CREATE TRIGGER Chance2_Arrive
AFTER UPDATE OF CurrentLocation ON Player
FOR EACH ROW
WHEN new.CurrentLocation = 10
BEGIN
    -- forward 3 steps
    UPDATE Player
    SET CurrentLocation = CurrentLocation + 3
    WHERE PlayerID = NEW.PlayerID;
END;

-- 2.5 pass COMMUNITY CHEST1
CREATE TRIGGER COMMUNITY_CHEST_1_Arrive
AFTER UPDATE OF CurrentLocation ON Player
FOR EACH ROW
WHEN new.CurrentLocation = 6
BEGIN
    -- +100
    UPDATE Player
    SET BankBalance = BankBalance + 100
    WHERE PlayerID = NEW.PlayerID;
END;

-- 2.6 pass COMMUNITY CHEST2
CREATE TRIGGER COMMUNITY_CHEST_2_Arrive
AFTER UPDATE OF CurrentLocation ON Player
FOR EACH ROW
WHEN new.CurrentLocation = 14
BEGIN
    --  -30
    UPDATE Player
    SET BankBalance = BankBalance - 30
    WHERE PlayerID = NEW.PlayerID;
END;



-- 2.7 Go to Jail
CREATE TRIGGER Jail_Arrive
AFTER UPDATE OF CurrentLocation ON Player
FOR EACH ROW
WHEN new.CurrentLocation = 12
BEGIN
    -- Go to Jail
    UPDATE Player
    SET InJail = 1,
        CurrentLocation = 4
    WHERE PlayerID = NEW.PlayerID;
END;

CREATE  TRIGGER Check_out_jail
AFTER UPDATE OF CurrentLocation ON Player
FOR EACH ROW
WHEN old.CurrentLocation = 4
BEGIN
    -- check out of jail
    UPDATE Player
    SET InJail = 0
    WHERE PlayerID = NEW.PlayerID;
END;


-- 3. Check whether the player is bankrupt
CREATE TRIGGER Check_Bankrupt
AFTER UPDATE OF BankBalance ON Player
FOR EACH ROW
WHEN new.BankBalance < 0
BEGIN

    UPDATE Player
    SET IsBankrupt = 1
    WHERE PlayerID = NEW.PlayerID;
END;

--4. insert data into audittrail after every round
CREATE TRIGGER insert_audittrail
AFTER UPDATE OF CurrentLocation ON Player
FOR EACH ROW
WHEN (OLD.CurrentLocation != 12) and (new.CurrentLocation != old.CurrentLocation)
BEGIN
    -- 往audit_trail插入新数据
    INSERT INTO AuditTrail (PlayerID, PositionID, BankBalance, GameRound)
    VALUES (new.PlayerID,new.CurrentLocation,(select BankBalance from Player WHERE Player.PlayerID = NEW.PlayerID),(SELECT max(AuditTrail.GameRound) FROM AuditTrail WHERE AuditTrail.PlayerID = NEW.PlayerID) + 1);
END;


SELECT name FROM sqlite_master WHERE type='trigger';
