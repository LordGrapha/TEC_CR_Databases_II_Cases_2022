-- Database Structures Creation
IF NOT EXISTS ( SELECT name FROM master.dbo.sysdatabases 
                WHERE name = N'Case_1' )
BEGIN
    CREATE DATABASE [Case_1];
END
GO

USE [Case_1];
GO

IF OBJECT_ID(N'dbo.PoliticParties', N'U') IS NULL
BEGIN
    CREATE TABLE PoliticParties (
		id INT IDENTITY(1,1) PRIMARY KEY,
		name VARCHAR(63) NOT NULL,
		flagPictureUrl VARCHAR(255) NOT NULL
	);
END
GO

IF OBJECT_ID(N'dbo.CampaignManagers', N'U') IS NULL
BEGIN
    CREATE TABLE CampaignManagers (
		id INT IDENTITY(1,1) PRIMARY KEY,
		bio VARCHAR(255) NOT NULL,
		pictureUrl VARCHAR(255) NOT NULL,
		politicPartyId INT NOT NULL FOREIGN KEY REFERENCES PoliticParties(id)
	);
END
GO

IF OBJECT_ID(N'dbo.Actions', N'U') IS NULL
BEGIN
    CREATE TABLE Actions (
		id INT IDENTITY(1,1) PRIMARY KEY,
		politicPartyId INT NOT NULL FOREIGN KEY REFERENCES PoliticParties(id),
		action VARCHAR(1022) NOT NULL
	);
END
GO

IF OBJECT_ID(N'dbo.Deliverables', N'U') IS NULL
BEGIN
	CREATE TABLE Deliverables (
		id INT IDENTITY(1,1) PRIMARY KEY,
		actionId INT NOT NULL FOREIGN KEY REFERENCES Actions(id),
		politicPartyId INT NOT NULL FOREIGN KEY REFERENCES PoliticParties(id),
		name VARCHAR(63) NOT NULL,
		date DATE NOT NULL
	);
END
GO

IF OBJECT_ID(N'dbo.Cantons', N'U') IS NULL
BEGIN
	CREATE TABLE Cantons (
		id INT IDENTITY(1,1) PRIMARY KEY,
		name VARCHAR(63) NOT NULL,
		politicPartiesSupport INT NOT NULL DEFAULT 0,
		deliverables INT NOT NULL DEFAULT 0
	);
END
GO

IF OBJECT_ID(N'dbo.CantonsXDeliverables', N'U') IS NULL
BEGIN
	CREATE TABLE CantonsXDeliverables (
		cantonId INT NOT NULL FOREIGN KEY REFERENCES Cantons(id),
		deliverableid INT NOT NULL FOREIGN KEY REFERENCES Deliverables(id),
		kpiValue INT NOT NULL,
		kpiEntity VARCHAR(63) NOT NULL
	);
END
GO

-- Database Tables Population

IF NOT EXISTS( SELECT id FROM [dbo].[PoliticParties])
BEGIN
	INSERT INTO [dbo].[PoliticParties] (name, flagPictureUrl) VALUES 
		('PAC',
		'https://i.ibb.co/7SkKYsV/PAC.png'),
		('CD',
		'https://i.ibb.co/GQS3FfH/CD-500.png'),
		('PLR',
		'https://i.ibb.co/84k30Yv/Partido-Liberal-Radical-Autentico-svg.png'),
		('RN',
		'https://i.ibb.co/tzhKTmM/Bandera-Partido-Restauraci-n-Nacional-Costa-Rica-2022-svg.png')
END

IF NOT EXISTS( SELECT id FROM [dbo].[CampaignManagers])
BEGIN
	INSERT INTO [dbo].[CampaignManagers] (bio, pictureUrl, politicPartyId)
	VALUES 
		('Doctor en Economia y politica',
		'https://i.ibb.co/7SkKYsV/PAC.png',
		1),
		('Doctor en AgroIndustria',
		'https://i.ibb.co/GQS3FfH/CD-500.png',
		2),
		('Agricultor',
		'https://i.ibb.co/84k30Yv/Partido-Liberal-Radical-Autentico-svg.png',
		3),
		('Licenciado Abogado',
		'https://i.ibb.co/tzhKTmM/Bandera-Partido-Restauraci-n-Nacional-Costa-Rica-2022-svg.png',
		4)
END

IF NOT EXISTS( SELECT id FROM [dbo].[Actions])
BEGIN
	-- PAC
	INSERT INTO [dbo].[Actions] (politicPartyId, action) VALUES
		(1, 'Reparar calles dañadas, restaurar calles en mal estado'),
		(1, 'Aumentar la seguridad ciudadana'),
		(1, 'Generar mas empleos'),
		(2, 'Reparar calles dañadas, restaurar calles en mal estado'),
		(2, 'Eliminar la corrupcion de la politica'),
		(2, 'Mejora del medio ambiente'),
		(3, 'Mejora en la educacion'),
		(3, 'Implementacion del tren electrico'),
		(3, 'Incorporacion de Buses biodegradables y electricos'),
		(4, 'Uso de energias renovables al 90% en todo el pais'),
		(4, 'Acceso a Internet a 90% en todo el pais'),
		(4, 'Eliminacion de la Analfabetizacion')

END

IF NOT EXISTS( SELECT id FROM [dbo].[Cantons])
BEGIN
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Abangares' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Acosta (San José, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Alajuela (Alajuela, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Alajuelita (San José, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Alvarado (Cartago, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Aserrí (San José, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Atenas (Alajuela, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Bagaces (Guanacaste, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Barva (Heredia, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Belén (Heredia, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Buenos Aires (Puntarenas, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Cañas (Guanacaste, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Carrillo (Guanacaste, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Cartago (Cartago, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Corredores (Puntarenas, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Coto Brus (Puntarenas, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Curridabat (San José, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Desamparados (San José, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Dota (San José, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'El Guarco (Cartago, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Escazú (San José, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Esparza (Puntarenas, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Flores (Heredia, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Garabito (Puntarenas, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Goicoechea (San José, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Golfito (Puntarenas, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Grecia (Alajuela, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Guácimo (Limón, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Guatuso (Alajuela, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Heredia (Heredia, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Hojancha (Guanacaste, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Jiménez (Cartago, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'La Cruz (Guanacaste, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'La Unión (Cartago, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'León Cortés (San José, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Liberia (Guanacaste, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Limón (Limón, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Los Chiles (Alajuela, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Matina (Limón, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Montes de Oca (San José, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Montes de Oro (Puntarenas, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Mora (San José, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Moravia (San José, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Nandayure (Guanacaste, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Naranjo (Alajuela, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Nicoya (Guanacaste, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Oreamuno (Cartago, CR)' )
	INSERT INTO [dbo].[Cantons] (name) VALUES( 'Orotina (Alajuela, CR)' )
END

-- Random inserts

--Virtual Table to add a bit of reality to random values

DECLARE @LOCAL_DeliverableNames TABLE (name VARCHAR(63))

INSERT INTO @LOCAL_DeliverableNames VALUES
	('Entregable de planeacion'),
	('Entregable de progreso'),
	('Entregable de Permisos publicos'),
	('Entregable de firmas'),
	('Entregable de evidencias fotos'),
	('Entregable de evidencias videos'),
	('Entregable de evidencias audios'),
	('Entregable de conclusion de la accion propuesta')

DECLARE @LOCAL_KPI TABLE (kpiValue INT, kpiEntity VARCHAR(63))

INSERT INTO @LOCAL_KPI VALUES
	(20,'Kilometros'),
	(10, 'Votos de aprobacion'),
	(5, 'Litros'),
	(100, 'Porcentaje de poblacion'),
	(30, 'Horas semanales'),
	(5, 'Estrellas de satisfaccion'),
	(67, 'Ganancia neta por dia'),
	(43, 'Avance semanal')

DECLARE @quantitypoliticparties INT
DECLARE @quantityactions INT
DECLARE @quantitydeliverables INT
DECLARE @politicpartyid INT
DECLARE @actionid INT
DECLARE @cantonid INT
DECLARE @deliv_name VARCHAR(63)
DECLARE @kpi_val INT
DECLARE @kpi_ent VARCHAR(63)
DECLARE @LOCAL_CantonsSupported TABLE (cantonid INT)

SELECT @quantitypoliticparties = COUNT(id) FROM dbo.PoliticParties
SELECT @quantityactions = COUNT(id) FROM dbo.Actions
SET @politicpartyid = 1
-- For each politic party
WHILE @politicpartyid <= @quantitypoliticparties
BEGIN
	SET @actionid = 1
	-- For each Action of that Politic party
	WHILE @actionid <= @quantityactions
	BEGIN
	-- Random between 3 and 7 | x belongs to [3,8[
		SELECT @quantitydeliverables = RAND()*(8-3)+3;
		-- For each Deliverable for each Action for each Politic Party
		WHILE @quantitydeliverables > 0
		BEGIN
			IF RAND() > 0.5 BEGIN
				-- Pick random id from ids in Cantons table
				SELECT TOP 1 @cantonid = id FROM dbo.Cantons ORDER BY NEWID()
			END ELSE BEGIN
				SELECT @cantonid = RAND()*(33-1)+1; 
			END

			-- Insert random deliverable for current Action in current Politic Party
			SELECT TOP 1 @deliv_name = name FROM @LOCAL_DeliverableNames ORDER BY NEWID()
			INSERT INTO dbo.Deliverables(actionId, politicPartyId, name, date) 
			VALUES (@actionid,
					@politicpartyid,
					@deliv_name,
					DATEADD(dd, 700*RAND(), '03/07/2022')
					)
			-- Insert random deliverable for current Action in current Politic Party
			SELECT TOP 1 @kpi_val = kpiValue, @kpi_ent = kpiEntity FROM @LOCAL_KPI ORDER BY NEWID()
			INSERT INTO dbo.CantonsXDeliverables(cantonId, deliverableId, kpiValue, kpiEntity) 
			VALUES (@cantonid,
					IDENT_CURRENT('Deliverables'),
					@kpi_val,
					@kpi_ent)
			UPDATE Cantons
				SET deliverables = deliverables + 1
			WHERE id = @cantonid
			IF NOT EXISTS (SELECT cantonid FROM @LOCAL_CantonsSupported as cs
						WHERE cs.cantonid = @cantonid)
			BEGIN
				UPDATE Cantons
					SET politicPartiesSupport = politicPartiesSupport + 1
				WHERE id = @cantonid
				INSERT INTO @LOCAL_CantonsSupported(cantonid) VALUES (@cantonid)
			END
			SET @quantitydeliverables =  @quantitydeliverables - 1
		END
		SET @actionid = @actionid + 1
	END
	SET @politicpartyid = @politicpartyid + 1
	DELETE @LOCAL_CantonsSupported
END

--Stored Procedures Definition, Query 1

IF object_id('Query1') IS NULL
BEGIN
	EXEC('CREATE PROCEDURE [dbo].[Query1]
	(@cantonName VARCHAR(63))
	AS
	BEGIN
		DECLARE @cantonID INT
		SELECT @cantonID = c.id FROM Cantons as c WHERE c.name = @cantonName

		SELECT d.name, c.name, p.name FROM dbo.Deliverables as d
		INNER JOIN dbo.PoliticParties as p ON p.id = d.politicPartyId
		INNER JOIN dbo.CantonsXDeliverables as cxd ON cxd.deliverableid = d.id
		INNER JOIN dbo.Cantons as c ON c.id = cxd.cantonId
		WHERE c.id = @cantonID
		ORDER BY p.id
	END')
END

IF object_id('Query3') IS NULL
BEGIN
	EXEC('CREATE PROCEDURE [dbo].[Query3]
	AS
	BEGIN
		SELECT p.name as PoliticParty,
			a.action as Action,
			[dbo].getMinCanton(a.id) as MinCanton,
			[dbo].getMinCantonDelivs(a.id) as deliverables,
			[dbo].getMaxCanton(a.id) as MaxCanton,
			[dbo].getMaxCantonDelivs(a.id) as deliverables
	FROM PoliticParties as p
		INNER JOIN dbo.Actions as a ON p.id = a.politicPartyId
		GROUP BY p.name, a.id, a.action, a.politicPartyId
		ORDER BY a.id
	END')
END

-- Query 1
EXEC dbo.Query1 'Abangares'

--Query 2
DECLARE @topPoliticParties INT 
SELECT @topPoliticParties = FLOOR(COUNT(id) * 0.25) FROM [dbo].[PoliticParties]
SELECT c.name, COUNT(d.id) as deliverables FROM Cantons as c
	INNER JOIN [dbo].[CantonsXDeliverables] as cxd ON c.id = cxd.cantonId
	INNER JOIN [dbo].[Deliverables] as d ON cxd.deliverableid = d.id
	WHERE c.politicPartiesSupport <= (SELECT FLOOR(COUNT(id) * 0.25) FROM [dbo].[PoliticParties])
	GROUP BY c.name

IF object_id('getMinCanton', 'FN') IS NULL
BEGIN
    EXEC('CREATE FUNCTION [dbo].[getMinCanton] (
	@actionid INT
	)
	RETURNS VARCHAR(63) AS
	BEGIN
		DECLARE	@return_value VARCHAR(63)

		SELECT TOP 1 @return_value = c.name FROM dbo.Cantons as c
			INNER JOIN dbo.CantonsXDeliverables as cxd ON cxd.cantonId = c.id
			INNER JOIN dbo.Deliverables as d ON cxd.cantonId = d.id
			INNER JOIN dbo.Actions as a ON d.actionId = a.id
			WHERE a.id = @actionid
			ORDER BY c.deliverables ASC
		RETURN @return_value
	END')
END

IF object_id('getMinCantonDelivs', 'FN') IS NULL
BEGIN
    EXEC('CREATE FUNCTION [dbo].[getMinCantonDelivs] (
	@actionid INT
	)
	RETURNS INT AS
	BEGIN
		DECLARE	@return_value INT

		SELECT TOP 1 @return_value = c.deliverables FROM dbo.Cantons as c
			INNER JOIN dbo.CantonsXDeliverables as cxd ON cxd.cantonId = c.id
			INNER JOIN dbo.Deliverables as d ON cxd.cantonId = d.id
			INNER JOIN dbo.Actions as a ON d.actionId = a.id
			WHERE a.id = @actionid
			ORDER BY c.deliverables ASC
		RETURN @return_value
	END')
END

IF object_id('getMaxCanton', 'FN') IS NULL
BEGIN
    EXEC('CREATE FUNCTION [dbo].[getMaxCanton] (
	@actionid INT
	)
	RETURNS VARCHAR(63) AS
	BEGIN
		DECLARE	@return_value VARCHAR(63)

		SELECT TOP 1 @return_value = c.name FROM dbo.Cantons as c
			INNER JOIN dbo.CantonsXDeliverables as cxd ON cxd.cantonId = c.id
			INNER JOIN dbo.Deliverables as d ON cxd.cantonId = d.id
			INNER JOIN dbo.Actions as a ON d.actionId = a.id
			WHERE a.id = @actionid
			ORDER BY c.deliverables DESC
		RETURN @return_value
	END')
END

IF object_id('getMaxCantonDelivs', 'FN') IS NULL
BEGIN
    EXEC('CREATE FUNCTION [dbo].[getMaxCantonDelivs] (
	@actionid INT
	)
	RETURNS INT AS
	BEGIN
		DECLARE	@return_value INT

		SELECT TOP 1 @return_value = c.deliverables FROM dbo.Cantons as c
			INNER JOIN dbo.CantonsXDeliverables as cxd ON cxd.cantonId = c.id
			INNER JOIN dbo.Deliverables as d ON cxd.cantonId = d.id
			INNER JOIN dbo.Actions as a ON d.actionId = a.id
			WHERE a.id = @actionid
			ORDER BY c.deliverables DESC
		RETURN @return_value
	END')
END

-- Query 3
SELECT p.name as PoliticParty,
		a.action as Action,
		[dbo].getMinCanton(a.id) as MinCanton,
		[dbo].getMinCantonDelivs(a.id) as deliverables,
		[dbo].getMaxCanton(a.id) as MaxCanton,
		[dbo].getMaxCantonDelivs(a.id) as deliverables
FROM PoliticParties as p
	INNER JOIN dbo.Actions as a ON p.id = a.politicPartyId
	GROUP BY p.name, a.id, a.action, a.politicPartyId
	ORDER BY a.id