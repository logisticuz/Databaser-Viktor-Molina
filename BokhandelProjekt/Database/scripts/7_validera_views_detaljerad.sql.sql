-- Validerar att antal titlar och totala lagervärdet per författare stämmer överens med tabellerna
SELECT Förnamn + ' ' + Efternamn AS Namn, 
       COUNT(DISTINCT ISBN13) AS AntalTitlar, 
       SUM(Pris * LagerSaldo.Antal) AS TotaltVärde
FROM Författare 
JOIN Böcker ON Författare.ID = Böcker.FörfattareID
JOIN LagerSaldo ON Böcker.ISBN13 = LagerSaldo.ISBN
GROUP BY Förnamn, Efternamn;

GO

-- Kontrollerar lagerstatus för en specifik butik baserat på ButikID
SELECT Butiksnamn, Adress, ISBN, Titel, Antal 
FROM LagerSaldo 
JOIN Butiker ON LagerSaldo.ButikID = Butiker.ID
JOIN Böcker ON LagerSaldo.ISBN = Böcker.ISBN13
WHERE Butiker.ID = 1; -- Specificerar en butik