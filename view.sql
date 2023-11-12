--Name:WU WEIXIN
--STUDENT ID: 11311800

Drop VIEW IF EXISTS Game_View;
CREATE VIEW Game_View AS
SELECT
    Name,
    Token,
    Location,
    Current_balance,
    GameRound,
    Injail,
    IsBankrupt,
    PositionName,
    GROUP_CONCAT(PropertyName ,',') AS Total_Properties
FROM
(SELECT PlayerName             AS Name,
           ChosenToken            AS Token,
           CurrentLocation        AS Location,
           p1.BankBalance            AS Current_balance,
           p4.GameRound              AS GameRound,
           InJail                 AS InJail,
           IsBankrupt             AS IsBankrupt,
           p3.PositionName        AS PositionName,
           p2.PropertyName
FROM Player as p1 left join
Properties as p2
ON p1.PlayerID = p2.OwnerID
left join Location as p3
ON p1.CurrentLocation = p3.PositionID
left join (SELECT AT.*
            FROM AuditTrail AT
            INNER JOIN (
              SELECT PlayerID, MAX(GameRound) AS MaxGameRound
              FROM AuditTrail
              GROUP BY PlayerID
            ) AS SubQuery
            ON AT.PlayerID = SubQuery.PlayerID AND AT.GameRound = SubQuery.MaxGameRound) as p4
ON p1.PlayerID = p4.PlayerID)
GROUP BY Name, Token, Location, Current_balance, GameRound, Injail, IsBankrupt,PositionName
ORDER BY Current_balance desc;








select *
from Game_View;