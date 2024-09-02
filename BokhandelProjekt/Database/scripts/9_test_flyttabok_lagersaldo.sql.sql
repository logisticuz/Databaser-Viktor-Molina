-- Kontrollerar lagersaldot f�re flytten
SELECT * FROM LagerSaldo WHERE ButikID = 1 AND ISBN = '9783161484100';
SELECT * FROM LagerSaldo WHERE ButikID = 2 AND ISBN = '9783161484100';

-- K�r proceduren FlyttaBok
EXEC FlyttaBok @FromButikID = 1, @ToButikID = 2, @ISBN = '9783161484100', @Antal = 5;

-- Kontrollerar lagersaldot efter flytten
SELECT * FROM LagerSaldo WHERE ButikID = 1 AND ISBN = '9783161484100';
SELECT * FROM LagerSaldo WHERE ButikID = 2 AND ISBN = '9783161484100';
