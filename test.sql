

UPDATE Player
SET CurrentLocation = 0
WHERE PlayerID = 3;

UPDATE Player
SET CurrentLocation = (CurrentLocation + 1) % 16
WHERE PlayerID = 4;

UPDATE Player
SET CurrentLocation = 12
WHERE PlayerID = 1;

UPDATE Player
SET CurrentLocation = CurrentLocation + 2
WHERE PlayerID = 2;

UPDATE Player
SET CurrentLocation = CurrentLocation + 5
WHERE PlayerID = 3;

UPDATE Player
SET CurrentLocation = CurrentLocation + 4
WHERE PlayerID = 4;

UPDATE Player
SET CurrentLocation = CurrentLocation + 5
WHERE PlayerID = 1;

UPDATE Player
-- SET CurrentLocation = (CurrentLocation + 9) % 16
set CurrentLocation = 6
WHERE PlayerID = 2;

SELECT *
FROM Game_View;