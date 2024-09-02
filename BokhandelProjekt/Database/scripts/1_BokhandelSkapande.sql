-- Kontrollerar om databasen redan finns, skapar den om den inte existerar
IF DB_ID('Bokhandel') IS NULL
BEGIN
    CREATE DATABASE Bokhandel;  -- Skapar databasen om den inte existerar
END
GO

USE Bokhandel;  -- Anv�nder databasen 'Bokhandel'
GO
-- Tabell f�r att lagra information om f�rfattare
create table F�rfattare (
    ID int identity(1,1) primary key,  
    F�rnamn nvarchar(100),
    Efternamn nvarchar(100),
    F�delsedatum date
);
GO

-- Tabell f�r att lagra information om f�rlag
create table F�rlag (
    F�rlagID int identity(1,1) primary key,  
    Namn nvarchar(100),
    Adress nvarchar(255)
);
GO

-- Tabell f�r att lagra information om butiker
create table Butiker (
    ID int identity(1,1) primary key,  
    Butiksnamn nvarchar(100),
    Adress nvarchar(255)
);
GO

-- Tabell f�r att lagra information om kunder
create table Kunder (
    KundID int identity(1,1) primary key,  
    Namn nvarchar(100),
    Epost nvarchar(100),
    Telefonnummer nvarchar(15)
);
GO

-- Tabell f�r att lagra orderinformation och referens till kunden som gjort best�llningen
create table Ordrar (
    OrderID int identity(1,1) primary key,  
    KundID int,  
    OrderDatum datetime,
    TotaltBelopp decimal(10, 2),
    foreign key (KundID) references Kunder(KundID)  
);
GO

-- Tabell f�r att lagra bokinformation, inklusive f�rfattare och f�rlag
CREATE TABLE B�cker (
    ISBN13 CHAR(13) PRIMARY KEY,  
    Titel NVARCHAR(200) NOT NULL,
    Spr�k NVARCHAR(50) NOT NULL,
    Pris DECIMAL(10, 2) NOT NULL CHECK (Pris > 0 AND Pris < 10000),  
    Utgivningsdatum DATE DEFAULT GETDATE(),
	F�rfattareID INT NOT NULL,  
    F�rlagID INT NOT NULL,  
    FOREIGN KEY (F�rfattareID) REFERENCES F�rfattare(ID), 
    FOREIGN KEY (F�rlagID) REFERENCES F�rlag(F�rlagID)  
);
GO

-- Tabell f�r att lagra information om lagersaldo i olika butiker
create table LagerSaldo (
    ButikID int, 
    ISBN char(13),  
    Antal int,
    primary key (ButikID, ISBN),  
    foreign key (ButikID) references Butiker(ID), 
    foreign key (ISBN) references B�cker(ISBN13)  
);
GO

-- Tabell f�r att lagra detaljer om vilka b�cker som ing�r i en order
create table Orderdetaljer (
    OrderID int, 
    ISBN char(13), 
    Antal int,
    primary key (OrderID, ISBN),  
    foreign key (OrderID) references Ordrar(OrderID),  
    foreign key (ISBN) references B�cker(ISBN13)  
);
GO
