-- Skapar en vy som sammanställer antal titlar och lagervärde per författare
CREATE VIEW TitlarPerFörfattare AS
SELECT
    f.Förnamn + ' ' + f.Efternamn AS Namn,
    DATEDIFF(year, f.Födelsedatum, GETDATE()) AS Ålder,
    COUNT(DISTINCT b.ISBN13) AS Titlar,
    SUM(b.Pris * ls.Antal) AS Lagervärde
FROM
    Författare f
JOIN
    Böcker b ON f.ID = b.FörfattareID
JOIN
    LagerSaldo ls ON b.ISBN13 = ls.ISBN
GROUP BY
    f.Förnamn, f.Efternamn, f.Födelsedatum;
GO

-- Skapar en vy som visar lagerstatus för varje bok i alla butiker
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
    Böcker bk ON ls.ISBN = bk.ISBN13;
GO
