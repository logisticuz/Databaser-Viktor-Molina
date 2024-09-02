-- H�mtar och visar alla f�rfattare fr�n tabellen F�rfattare
SELECT * FROM F�rfattare;

-- H�mtar och visar alla b�cker tillsammans med deras respektive f�rfattare och f�rlag
SELECT B.*, F.F�rnamn + ' ' + F.Efternamn AS F�rfattareNamn, FL.Namn AS F�rlagsNamn
FROM B�cker B
LEFT JOIN F�rfattare F ON B.F�rfattareID = F.ID
LEFT JOIN F�rlag FL ON B.F�rlagID = FL.F�rlagID;

-- H�mtar och visar lagersaldo f�r alla butiker inklusive boktitlar
SELECT B.Butiksnamn, L.ISBN, Bo.Titel, L.Antal
FROM LagerSaldo L
JOIN Butiker B ON L.ButikID = B.ID
JOIN B�cker Bo ON L.ISBN = Bo.ISBN13;

-- H�mtar och visar alla kundorder inklusive ordertotaler och kundinformation
SELECT K.Namn, K.Epost, O.OrderID, O.OrderDatum, O.TotaltBelopp
FROM Ordrar O
JOIN Kunder K ON O.KundID = K.KundID;
