-- Kontrollerar lagersaldot före flytten
SELECT * FROM LagerSaldo WHERE ButikID = 1 AND ISBN = '9783161484100';
SELECT * FROM LagerSaldo WHERE ButikID = 2 AND ISBN = '9783161484100';

-- Kör proceduren FlyttaBok
EXEC FlyttaBok @FromButikID = 1, @ToButikID = 2, @ISBN = '9783161484100', @Antal = 5;

-- Kontrollerar lagersaldot efter flytten
SELECT * FROM LagerSaldo WHERE ButikID = 1 AND ISBN = '9783161484100';
SELECT * FROM LagerSaldo WHERE ButikID = 2 AND ISBN = '9783161484100';
