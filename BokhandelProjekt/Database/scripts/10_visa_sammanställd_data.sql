-- Hämtar och visar alla författare från tabellen Författare
SELECT * FROM Författare;

-- Hämtar och visar alla böcker tillsammans med deras respektive författare och förlag
SELECT B.*, F.Förnamn + ' ' + F.Efternamn AS FörfattareNamn, FL.Namn AS FörlagsNamn
FROM Böcker B
LEFT JOIN Författare F ON B.FörfattareID = F.ID
LEFT JOIN Förlag FL ON B.FörlagID = FL.FörlagID;

-- Hämtar och visar lagersaldo för alla butiker inklusive boktitlar
SELECT B.Butiksnamn, L.ISBN, Bo.Titel, L.Antal
FROM LagerSaldo L
JOIN Butiker B ON L.ButikID = B.ID
JOIN Böcker Bo ON L.ISBN = Bo.ISBN13;

-- Hämtar och visar alla kundorder inklusive ordertotaler och kundinformation
SELECT K.Namn, K.Epost, O.OrderID, O.OrderDatum, O.TotaltBelopp
FROM Ordrar O
JOIN Kunder K ON O.KundID = K.KundID;
