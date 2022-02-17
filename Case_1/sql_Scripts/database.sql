-- Database Structures Creation
IF NOT EXISTS ( SELECT name FROM master.dbo.sysdatabases 
                WHERE name = N'Case_1' )
BEGIN
    CREATE DATABASE [Case_1];
END
GO

USE Case_1;
GO

IF OBJECT_ID(N'dbo.PoliticParties', N'U') IS NULL
BEGIN
    CREATE TABLE PoliticParties (
		id INT IDENTITY(1,1) PRIMARY KEY,
		name VARCHAR(63),
		flagPictureUrl VARCHAR(255)
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
		name VARCHAR(63) NOT NULL,
		date DATE NOT NULL
	);
END
GO

IF OBJECT_ID(N'dbo.Cantons', N'U') IS NULL
BEGIN
	CREATE TABLE Cantons (
		id INT IDENTITY(1,1) PRIMARY KEY,
		name VARCHAR(63) NOT NULL
	);
END
GO

IF OBJECT_ID(N'dbo.CantonsXDeliverables', N'U') IS NULL
BEGIN
	CREATE TABLE CantonsXDeliverables (
		cantonId INT NOT NULL FOREIGN KEY REFERENCES Cantons(id),
		actionId INT NOT NULL FOREIGN KEY REFERENCES Actions(id),
		kpiValue INT NOT NULL,
		kpiEntity VARCHAR(63) NOT NULL
	);
END
GO

-- Database Tables Population

IF NOT EXISTS( SELECT id FROM [dbo].[PoliticParties])
BEGIN
	INSERT INTO [dbo].[PoliticParties] (name, flagPictureUrl)
	VALUES (
		'PAC',
		'https://i.ibb.co/7SkKYsV/PAC.png'
	);
	INSERT INTO [dbo].[PoliticParties] (name, flagPictureUrl)
	VALUES (
		'CD',
		'https://i.ibb.co/GQS3FfH/CD-500.png'
	);
	INSERT INTO [dbo].[PoliticParties] (name, flagPictureUrl)
	VALUES (
		'PLR',
		'https://i.ibb.co/84k30Yv/Partido-Liberal-Radical-Autentico-svg.png'
	);
	INSERT INTO [dbo].[PoliticParties] (name, flagPictureUrl)
	VALUES (
		'RN',
		'https://i.ibb.co/tzhKTmM/Bandera-Partido-Restauraci-n-Nacional-Costa-Rica-2022-svg.png'
	);
END
GO

SELECT * FROM PoliticParties;

IF NOT EXISTS( SELECT id FROM [dbo].[CampaignManagers])
BEGIN
	INSERT INTO [dbo].[CampaignManagers] (bio, pictureUrl, politicPartyId)
	VALUES (
		'Doctor en Economia y politica',
		'https://i.ibb.co/7SkKYsV/PAC.png',
		1
	);
	INSERT INTO [dbo].[CampaignManagers] (bio, pictureUrl, politicPartyId)
	VALUES (
		'Doctor en AgroIndustria',
		'https://i.ibb.co/GQS3FfH/CD-500.png',
		2
	);
	INSERT INTO [dbo].[CampaignManagers] (bio, pictureUrl, politicPartyId)
	VALUES (
		'Agricultor',
		'https://i.ibb.co/84k30Yv/Partido-Liberal-Radical-Autentico-svg.png',
		3
	);
	INSERT INTO [dbo].[CampaignManagers] (bio, pictureUrl, politicPartyId)
	VALUES (
		'Licenciado Abogado',
		'https://i.ibb.co/tzhKTmM/Bandera-Partido-Restauraci-n-Nacional-Costa-Rica-2022-svg.png',
		4
	);
END
GO;

/*
	mínimo 4 partidos, 3 acciones de plan y para cada acción entre 3 a 
	7 entregables en cantones diferentes, esto último aleatoriamente
*/

IF NOT EXISTS( SELECT id FROM [dbo].[Actions])
BEGIN
	-- PAC
	INSERT INTO [dbo].[Actions] (politicPartyId, action)
	VALUES(
		1,
		'Reparar calles dañadas, restaurar calles en mal estado'
	)

	INSERT INTO [dbo].[Actions] (politicPartyId, action)
	VALUES(
		1,
		'Aumentar la seguridad ciudadana'
	)

	INSERT INTO [dbo].[Actions] (politicPartyId, action)
	VALUES(
		1,
		'Generar mas empleos'
	)

	-- CD
	INSERT INTO [dbo].[Actions] (politicPartyId, action)
	VALUES(
		2,
		'Reparar calles dañadas, restaurar calles en mal estado'
	)

	INSERT INTO [dbo].[Actions] (politicPartyId, action)
	VALUES(
		2,
		'Eliminar la corrupcion de la politica'
	)

	INSERT INTO [dbo].[Actions] (politicPartyId, action)
	VALUES(
		2,
		'Reparar calles dañadas, restaurar calles en mal estado'
	)

	-- PLR
	INSERT INTO [dbo].[Actions] (politicPartyId, action)
	VALUES(
		3,
		'Reparar calles dañadas, restaurar calles en mal estado'
	)

	INSERT INTO [dbo].[Actions] (politicPartyId, action)
	VALUES(
		3,
		'Reparar calles dañadas, restaurar calles en mal estado'
	)

	INSERT INTO [dbo].[Actions] (politicPartyId, action)
	VALUES(
		3,
		'Reparar calles dañadas, restaurar calles en mal estado'
	)

	-- RN
	INSERT INTO [dbo].[Actions] (politicPartyId, action)
	VALUES(
		4,
		'Reparar calles dañadas, restaurar calles en mal estado'
	)

	INSERT INTO [dbo].[Actions] (politicPartyId, action)
	VALUES(
		4,
		'Reparar calles dañadas, restaurar calles en mal estado'
	)

	INSERT INTO [dbo].[Actions] (politicPartyId, action)
	VALUES(
		4,
		'Reparar calles dañadas, restaurar calles en mal estado'
	)

END
GO;

IF NOT EXISTS( SELECT id FROM [dbo].[Deliverables])
BEGIN

	INSERT INTO [dbo].[Deliverables] (actionId, name, date)
	VALUES(
		
	)

END
GO;

IF NOT EXISTS( SELECT id FROM [dbo].[CantonsXDeliverables])
BEGIN
	INSERT INTO [dbo].[CantonsXDeliverables] 
	VALUES(
		
	)
END
GO;

IF NOT EXISTS( SELECT id FROM [dbo].[Cantons])
BEGIN
	INSERT INTO [dbo].[Cantons] 
	VALUES(
		
	)
END
GO;



--Stored Procedures Definition

IF object_id('Query1') IS NULL
BEGIN
	EXEC('CREATE PROCEDURE [dbo].[Query1]
	(
	@cantonName VARCAHR(63)
	)
	AS
	BEGIN
		DECLARE @cantonID = SELECT id FROM Cantons WHERE name = @cantonName;
		SELECT d.name, d.Date, cxd.kpiValue, cxd.kpiEntity FROM [dbo].[Cantons] as c
			INNER JOIN [dbo][CantonsXDeliverables] as cxd ON c.id = cxd.cantonId
			INNER JOIN [dbo].[Deliverables] as d ON cxd.deliverableId = d.id
			INNER JOIN [dbo].[Actions] as a ON a.id = d.actionId
			INNER JOIN [dbo].[PoliticParties] as p ON p.id = a.politicPartyId;
			GROUP BY p.name
	END')
END
GO

IF object_id('Query2') IS NULL
BEGIN
	EXEC('CREATE PROCEDURE [dbo].[Query2]
	AS
	BEGIN
		DECLARE @topPoliticParties = SELECT FLOOR(COUNT(id) * 0.25) FROM [dbo].[PoliticParties];
		SELECT c.name, COUNT(d.id) FROM Cantons as c
			INNER JOIN [dbo][CantonsXDeliverables] as cxd ON c.id = cxd.cantonId
			INNER JOIN [dbo].[Deliverables] as d ON cxd.deliverableId = d.id
			INNER JOIN [dbo].[Actions] as a ON a.id = d.actionId
			INNER JOIN [dbo].[PoliticParties] as p ON p.id = a.politicPartyId;
			GROUP BY c.name
	END')
END
GO


/*
RANDOM INSERT EXAMPLE

DECLARE @quantitylogs INT
DECLARE @actiontypeid SMALLINT
DECLARE @solutionid BIGINT

SET @quantitylogs = 10000

SELECT TOP 1 @actiontypeid = actiontypeid FROM dbo.sd_actiontypes ORDER BY NEWID()
WHILE @quantitylogs>0
BEGIN
	IF RAND()>0.7 BEGIN
		SELECT TOP 1 @actiontypeid = actiontypeid FROM dbo.sd_actiontypes ORDER BY NEWID()
	END ELSE BEGIN
		SELECT @actiontypeid = CONVERT(INT, 4*RAND()) + 1 
	END

	SELECT TOP 1 @solutionid = solutionid FROM dbo.sd_solutions ORDER BY NEWID()

	INSERT INTO dbo.sd_solutionslog (actiontypeid, solutionid, posttime) 
	VALUES (@actiontypeid,
			@solutionid,
			DATEADD(dd, 700*RAND(), '03/04/2019')
			)
	SET @quantitylogs =  @quantitylogs - 1
END
*/