-- Kontrollerar om databasen redan finns, skapar den om den inte existerar
IF DB_ID('Bokhandel') IS NULL
BEGIN
    CREATE DATABASE Bokhandel;  -- Skapar databasen om den inte existerar
END
GO

USE Bokhandel;  -- Använder databasen 'Bokhandel'
GO
-- Tabell för att lagra information om författare
create table Författare (
    ID int identity(1,1) primary key,  
    Förnamn nvarchar(100),
    Efternamn nvarchar(100),
    Födelsedatum date
);
GO

-- Tabell för att lagra information om förlag
create table Förlag (
    FörlagID int identity(1,1) primary key,  
    Namn nvarchar(100),
    Adress nvarchar(255)
);
GO

-- Tabell för att lagra information om butiker
create table Butiker (
    ID int identity(1,1) primary key,  
    Butiksnamn nvarchar(100),
    Adress nvarchar(255)
);
GO

-- Tabell för att lagra information om kunder
create table Kunder (
    KundID int identity(1,1) primary key,  
    Namn nvarchar(100),
    Epost nvarchar(100),
    Telefonnummer nvarchar(15)
);
GO

-- Tabell för att lagra orderinformation och referens till kunden som gjort beställningen
create table Ordrar (
    OrderID int identity(1,1) primary key,  
    KundID int,  
    OrderDatum datetime,
    TotaltBelopp decimal(10, 2),
    foreign key (KundID) references Kunder(KundID)  
);
GO

-- Tabell för att lagra bokinformation, inklusive författare och förlag
CREATE TABLE Böcker (
    ISBN13 CHAR(13) PRIMARY KEY,  
    Titel NVARCHAR(200) NOT NULL,
    Språk NVARCHAR(50) NOT NULL,
    Pris DECIMAL(10, 2) NOT NULL CHECK (Pris > 0 AND Pris < 10000),  
    Utgivningsdatum DATE DEFAULT GETDATE(),
	FörfattareID INT NOT NULL,  
    FörlagID INT NOT NULL,  
    FOREIGN KEY (FörfattareID) REFERENCES Författare(ID), 
    FOREIGN KEY (FörlagID) REFERENCES Förlag(FörlagID)  
);
GO

-- Tabell för att lagra information om lagersaldo i olika butiker
create table LagerSaldo (
    ButikID int, 
    ISBN char(13),  
    Antal int,
    primary key (ButikID, ISBN),  
    foreign key (ButikID) references Butiker(ID), 
    foreign key (ISBN) references Böcker(ISBN13)  
);
GO

-- Tabell för att lagra detaljer om vilka böcker som ingår i en order
create table Orderdetaljer (
    OrderID int, 
    ISBN char(13), 
    Antal int,
    primary key (OrderID, ISBN),  
    foreign key (OrderID) references Ordrar(OrderID),  
    foreign key (ISBN) references Böcker(ISBN13)  
);
GO
