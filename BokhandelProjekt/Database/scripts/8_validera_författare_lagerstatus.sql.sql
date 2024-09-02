-- Validerar att antal titlar och totala lagerv�rdet per f�rfattare st�mmer �verens med tabellerna
SELECT F�rnamn + ' ' + Efternamn AS Namn, 
       COUNT(DISTINCT ISBN13) AS AntalTitlar, 
       SUM(Pris * LagerSaldo.Antal) AS TotaltV�rde
FROM F�rfattare 
JOIN B�cker ON F�rfattare.ID = B�cker.F�rfattareID
JOIN LagerSaldo ON B�cker.ISBN13 = LagerSaldo.ISBN
GROUP BY F�rnamn, Efternamn;

GO

-- Kontrollerar lagerstatus f�r en specifik butik baserat p� ButikID
SELECT Butiksnamn, Adress, ISBN, Titel, Antal 
FROM LagerSaldo 
JOIN Butiker ON LagerSaldo.ButikID = Butiker.ID
JOIN B�cker ON LagerSaldo.ISBN = B�cker.ISBN13
WHERE Butiker.ID = 1; -- Specificerar en butik