-- Skapar en vy som sammanst�ller antal titlar och lagerv�rde per f�rfattare
CREATE VIEW TitlarPerF�rfattare AS
SELECT
    f.F�rnamn + ' ' + f.Efternamn AS Namn,
    DATEDIFF(year, f.F�delsedatum, GETDATE()) AS �lder,
    COUNT(DISTINCT b.ISBN13) AS Titlar,
    SUM(b.Pris * ls.Antal) AS Lagerv�rde
FROM
    F�rfattare f
JOIN
    B�cker b ON f.ID = b.F�rfattareID
JOIN
    LagerSaldo ls ON b.ISBN13 = ls.ISBN
GROUP BY
    f.F�rnamn, f.Efternamn, f.F�delsedatum;
GO

-- Skapar en vy som visar lagerstatus f�r varje bok i alla butiker
CREATE VIEW ButikLagerStatus AS
SELECT 
    b.Butiksnamn,
    b.Adress,
    ls.ISBN,
    bk.Titel,
    ls.Antal
FROM 
    LagerSaldo ls
JOIN 
    Butiker b ON ls.ButikID = b.ID
JOIN 
    B�cker bk ON ls.ISBN = bk.ISBN13;
GO
