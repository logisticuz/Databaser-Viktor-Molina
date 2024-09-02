-- Skapar en stored procedure för att flytta ett antal exemplar av en bok mellan två butiker
CREATE PROCEDURE FlyttaBok
    @FromButikID int,     -- ID för butiken det flyttas ifrån
    @ToButikID int,       -- ID för butiken det flyttas till
    @ISBN char(13),       -- ISBN för boken som ska flyttas
    @Antal int = 1        -- Antalet exemplar att flytta (default 1)
AS
BEGIN
    SET NOCOUNT ON;  -- -- Förhindrar extra resultatuppsättningar för att förbättra prestanda

    
    -- Kontrollerar att både avsändande och mottagande butiker existerar
    IF NOT EXISTS (SELECT 1 FROM Butiker WHERE ID = @FromButikID)
    BEGIN
        RAISERROR('Ogiltigt FromButikID', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Butiker WHERE ID = @ToButikID)
    BEGIN
        RAISERROR('Ogiltigt ToButikID', 16, 1);
        RETURN;
    END

    -- Kontrollerar att det finns tillräckligt med exemplar i den avsändande butiken
    IF NOT EXISTS (SELECT 1 FROM LagerSaldo 
                   WHERE ButikID = @FromButikID AND ISBN = @ISBN AND Antal >= @Antal)
    BEGIN
        RAISERROR('Inte tillräckligt med exemplar i lager för att flytta', 16, 1);
        RETURN;
    END

    -- Minskar antalet exemplar i den avsändande butiken
    UPDATE LagerSaldo
    SET Antal = Antal - @Antal
    WHERE ButikID = @FromButikID AND ISBN = @ISBN;

    -- Kontrollerar om boken redan finns i den mottagande butiken och uppdaterar lagersaldot
    IF EXISTS (SELECT 1 FROM LagerSaldo WHERE ButikID = @ToButikID AND ISBN = @ISBN)
    BEGIN
        -- Ökar antalet exemplar i den mottagande butiken
        UPDATE LagerSaldo
        SET Antal = Antal + @Antal
        WHERE ButikID = @ToButikID AND ISBN = @ISBN;
    END
    ELSE
    BEGIN
        -- Lägger till en ny rad om boken inte redan finns i den mottagande butiken
        INSERT INTO LagerSaldo (ButikID, ISBN, Antal)
        VALUES (@ToButikID, @ISBN, @Antal);
    END
END;
GO
