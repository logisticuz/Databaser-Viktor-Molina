-- Skapar en stored procedure f�r att flytta ett antal exemplar av en bok mellan tv� butiker
CREATE PROCEDURE FlyttaBok
    @FromButikID int,     -- ID f�r butiken det flyttas ifr�n
    @ToButikID int,       -- ID f�r butiken det flyttas till
    @ISBN char(13),       -- ISBN f�r boken som ska flyttas
    @Antal int = 1        -- Antalet exemplar att flytta (default 1)
AS
BEGIN
    SET NOCOUNT ON;  -- -- F�rhindrar extra resultatupps�ttningar f�r att f�rb�ttra prestanda

    
    -- Kontrollerar att b�de avs�ndande och mottagande butiker existerar
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

    -- Kontrollerar att det finns tillr�ckligt med exemplar i den avs�ndande butiken
    IF NOT EXISTS (SELECT 1 FROM LagerSaldo 
                   WHERE ButikID = @FromButikID AND ISBN = @ISBN AND Antal >= @Antal)
    BEGIN
        RAISERROR('Inte tillr�ckligt med exemplar i lager f�r att flytta', 16, 1);
        RETURN;
    END

    -- Minskar antalet exemplar i den avs�ndande butiken
    UPDATE LagerSaldo
    SET Antal = Antal - @Antal
    WHERE ButikID = @FromButikID AND ISBN = @ISBN;

    -- Kontrollerar om boken redan finns i den mottagande butiken och uppdaterar lagersaldot
    IF EXISTS (SELECT 1 FROM LagerSaldo WHERE ButikID = @ToButikID AND ISBN = @ISBN)
    BEGIN
        -- �kar antalet exemplar i den mottagande butiken
        UPDATE LagerSaldo
        SET Antal = Antal + @Antal
        WHERE ButikID = @ToButikID AND ISBN = @ISBN;
    END
    ELSE
    BEGIN
        -- L�gger till en ny rad om boken inte redan finns i den mottagande butiken
        INSERT INTO LagerSaldo (ButikID, ISBN, Antal)
        VALUES (@ToButikID, @ISBN, @Antal);
    END
END;
GO
