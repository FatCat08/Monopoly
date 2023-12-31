--Name:WU WEIXIN
--STUDENT ID: 11311800

-- Token
Drop TABLE IF EXISTS Token;
CREATE TABLE IF NOT EXISTS Token(
	TokenID INT PRIMARY KEY,
	TokenName VARCHAR(30) NOT NULL
);

-- Location
Drop TABLE IF EXISTS Location;
CREATE TABLE IF NOT EXISTS Location(
	PositionID INT PRIMARY KEY,
	PositionName VARCHAR(30) NOT NULL,
	PositionType VARCHAR(30) NOT NULL
);

-- Properties
Drop TABLE IF EXISTS Properties;
CREATE TABLE IF NOT EXISTS Properties(
	PropertyID INT PRIMARY KEY,
	PropertyName VARCHAR(30) NOT NULL,
	PurchaseCost INT NOT NULL,
	RentCost INT NOT NULL,
	Color VARCHAR(10) NOT NULL,
	OwnerID INT,
	PositionID INT NOT NULL,
	CONSTRAINT fk_posid FOREIGN KEY (PositionID) REFERENCES Location(PositionID)
);

--Bonus
Drop TABLE IF EXISTS Bonus;
CREATE TABLE IF NOT EXISTS Bonus(
	BonusID INT PRIMARY KEY,
	BonusName VARCHAR(30) NOT NULL,
	Description VARCHAR(256) NOT NULL,
	PositionID INT NOT NULL,
	CONSTRAINT fk_posid1 FOREIGN KEY (PositionID) REFERENCES Location(PositionID)
);


--Player
Drop TABLE IF EXISTS Player;
CREATE TABLE IF NOT EXISTS Player(
	PlayerID INT PRIMARY KEY,
	PlayerName VARCHAR(20) NOT NULL,
	ChosenToken INT NOT NULL,
	BankBalance INT NOT NULL,
	CurrentLocation INT NOT NULL,
	InJail INT NOT NULL,
	IsBankrupt INT NOT NULL,
    GameRound INT NOT NULL,
	CONSTRAINT fk_CurrentLocation FOREIGN KEY (CurrentLocation) REFERENCES Location(PositionID),
	CONSTRAINT fk_Token FOREIGN KEY (ChosenToken) REFERENCES Token(TokenID)
);

-- AuditTrail
Drop TABLE IF EXISTS AuditTrail;
CREATE TABLE IF NOT EXISTS AuditTrail(
	RecordID INTEGER PRIMARY KEY AUTOINCREMENT ,
	PlayerID INT NOT NULL,
	PositionID INT NOT NULL,
	BankBalance INT NOT NULL,
	GameRound INT NOT NULL,
	CONSTRAINT fk_PlayerID FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID),
	CONSTRAINT fk_posid2 FOREIGN KEY (PositionID) REFERENCES Location(PositionID)
);
