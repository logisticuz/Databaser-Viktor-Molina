-- Infogar testdata författare
insert into Författare (Förnamn, Efternamn, Födelsedatum) values
('Juan', 'Galvez', '1980-04-14'),
('Julia', 'Strömberg', '1974-07-07'),
('Anna', 'Andersson', '1985-12-11'),
('Erik', 'Johansson', '1990-03-22'),
('Lisa', 'Svensson', '1978-08-30'),
('Karl', 'Nilsson', '1967-11-01'),
('Maria', 'Lindgren', '1983-06-16'),
('Olof', 'Karlsson', '1992-09-05'),
('Eva', 'Berg', '1971-01-15'),
('Fredrik', 'Persson', '1988-07-24'),
('Sofia', 'Eriksson', '1995-02-13'),
('Gustav', 'Olsson', '1982-04-09'),
('Helena', 'Larsson', '1977-10-21'),
('Anders', 'Holm', '1981-05-31'),
('Emma', 'Håkansson', '1989-12-02'),
('Patrik', 'Axelsson', '1975-11-18'),
('Mikaela', 'Lund', '1983-07-03'),
('Henrik', 'Björk', '1991-03-08'),
('Camilla', 'Engström', '1986-08-25'),
('Thomas', 'Franzén', '1993-05-19');

GO

-- Infogar testdata förlag
insert into Förlag (Namn, Adress) values 
('Förlag 1', 'Gatan 1, Stad A'),
('Förlag 2', 'Vägen 2, Stad B'),
('Förlag 3', 'Torget 3, Stad C');

GO

-- Infogar testdata butiker
insert into Butiker (Butiksnamn, Adress) values 
('Bokbutik A', 'Gatan 1, Stad A'),
('Bokbutik B', 'Plats 2, Stad B'),
('Bokbutik C', 'Väg 3, Stad C');

GO

-- Infogar testdata kunder
insert into Kunder (Namn, Epost, Telefonnummer) values 
('Kund A', 'kund.a@example.com', '0701234567'),
('Kund B', 'kund.b@example.com', '0702345678'),
('Kund C', 'kund.c@example.com', '0703456789'),
('Kund D', 'kund.d@example.com', '0704567890'),
('Kund E', 'kund.e@example.com', '0712345678'),
('Kund F', 'kund.f@example.com', '0723456789'),
('Kund G', 'kund.g@example.com', '0734567890'),
('Kund H', 'kund.h@example.com', '0745678901'),
('Kund I', 'kund.i@example.com', '0756789012');

GO

-- Infogar testdata böcker
insert into Böcker (ISBN13, Titel, Språk, Pris, Utgivningsdatum, FörfattareID, FörlagID) values
('9783161484100', 'Boktitel 1', 'Svenska', 250.00, '2023-01-01', 1, 3),
('9783161484101', 'Boktitel 2', 'Engelska', 300.00, '2023-02-01', 2, 2),
('9783161484102', 'Boktitel 3', 'Tyska', 150.00, '2023-03-01', 3, 1),
('9783161484103', 'Boktitel 4', 'Franska', 220.00, '2023-04-01', 4, 3),
('9783161484104', 'Boktitel 5', 'Spanska', 180.00, '2023-05-01', 5, 2),
('9783161484105', 'Boktitel 6', 'Italienska', 275.00, '2023-06-01', 6, 1),
('9783161484106', 'Boktitel 7', 'Portugisiska', 320.00, '2023-07-01', 7, 3),
('9783161484107', 'Boktitel 8', 'Norska', 200.00, '2023-08-01', 8, 2),
('9783161484108', 'Boktitel 9', 'Danska', 310.00, '2023-09-01', 9, 1),
('9783161484109', 'Boktitel 10', 'Finska', 230.00, '2023-10-01', 10, 3),
('9783161484110', 'Boktitel 11', 'Ryska', 290.00, '2023-11-01', 11, 2),
('9783161484111', 'Boktitel 12', 'Kinesiska', 400.00, '2023-12-01', 12, 1),
('9783161484112', 'Boktitel 13', 'Japanska', 340.00, '2024-01-01', 13, 3),
('9783161484113', 'Boktitel 14', 'Arabiska', 360.00, '2024-02-01', 14, 2),
('9783161484114', 'Boktitel 15', 'Hebreiska', 210.00, '2024-03-01', 15, 1);


GO

-- Infogar testdata lagerstatus
insert into LagerSaldo (ButikID, ISBN, Antal) values 
(1, '9783161484100', 50),
(1, '9783161484101', 30),
(2, '9783161484102', 20),
(3, '9783161484103', 40),
(1, '9783161484104', 15),
(2, '9783161484105', 25),
(3, '9783161484106', 35),
(1, '9783161484107', 10),
(2, '9783161484108', 45),
(3, '9783161484109', 20),
(1, '9783161484110', 50),
(2, '9783161484111', 30),
(3, '9783161484112', 40),
(1, '9783161484113', 15),
(2, '9783161484114', 25);

GO

-- Infogar testdata för ordrar i tabellen
insert into Ordrar (KundID, OrderDatum, TotaltBelopp) values 
(1, '2024-08-01', 500.00),
(2, '2024-08-02', 300.00),
(3, '2024-08-03', 450.00),
(1, '2024-08-04', 600.00),
(2, '2024-08-05', 700.00),
(3, '2024-08-06', 800.00),
(1, '2024-08-07', 900.00),
(2, '2024-08-08', 1000.00),
(3, '2024-08-09', 1100.00);

GO

-- Infogar testdata orderdetaljer
insert into Orderdetaljer (OrderID, ISBN, Antal) values
(1, '9783161484100', 2),
(1, '9783161484101', 1),
(2, '9783161484102', 1),
(2, '9783161484103', 2),
(3, '9783161484104', 1),
(4, '9783161484105', 2),
(4, '9783161484106', 3),
(5, '9783161484107', 1),
(5, '9783161484108', 4),
(6, '9783161484109', 2),
(6, '9783161484110', 3),
(7, '9783161484111', 4),
(7, '9783161484112', 2),
(8, '9783161484113', 1),
(8, '9783161484114', 2),
(9, '9783161484100', 1),
(9, '9783161484101', 2),
(9, '9783161484102', 3);

GO
