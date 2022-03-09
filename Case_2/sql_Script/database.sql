-- Database Structures Creation
IF NOT EXISTS ( SELECT name FROM master.dbo.sysdatabases 
                WHERE name = N'Case_2' )
BEGIN
    CREATE DATABASE [Case_2];
END
GO

USE [Case_2];
GO

IF OBJECT_ID(N'dbo.PoliticParties', N'U') IS NULL
BEGIN
    CREATE TABLE PoliticParties (
		politicpartyid INT IDENTITY(1,1) PRIMARY KEY,
		name VARCHAR(63) NOT NULL,
		flagPictureUrl VARCHAR(255) NOT NULL,
		posttime DATE NOT NULL DEFAULT GETDATE(),
		deleted BIT NOT NULL DEFAULT 0,
		enabled BIT NOT NULL DEFAULT 1
	);
END
GO

IF OBJECT_ID(N'dbo.Users', N'U') IS NULL
BEGIN
    CREATE TABLE Users (
		userid INT IDENTITY(1,1) PRIMARY KEY,
		firstname VARCHAR(63) NOT NULL,
		secondname VARCHAR(63) NOT NULL,
		lastname VARCHAR(63) NOT NULL,
		idcard VARCHAR(15) NOT NULL,
		posttime DATE NOT NULL DEFAULT GETDATE(),
		deleted BIT NOT NULL DEFAULT 0,
		enabled BIT NOT NULL DEFAULT 1
	);
END
GO

IF OBJECT_ID(N'dbo.Roles', N'U') IS NULL
BEGIN
    CREATE TABLE Roles (
		roleid INT IDENTITY(1,1) PRIMARY KEY,
		rolename VARCHAR(31),
		posttime DATE NOT NULL DEFAULT GETDATE(),
		deleted BIT NOT NULL DEFAULT 0,
		enabled BIT NOT NULL DEFAULT 1
	);
END
GO

IF OBJECT_ID(N'dbo.UsersXRoles', N'U') IS NULL
BEGIN
    CREATE TABLE UsersXRoles (
		roleid INT NOT NULL,
		CONSTRAINT FK_roles_userxroles
		FOREIGN KEY (roleid) REFERENCES Roles(roleid),
		userid INT NOT NULL,
		CONSTRAINT FK_users_userxroles
		FOREIGN KEY (userid) REFERENCES Users(userid)
	);
END
GO

IF OBJECT_ID(N'dbo.Citizens', N'U') IS NULL
BEGIN
    CREATE TABLE Citizens (
		citizenid INT IDENTITY(1,1) PRIMARY KEY,
		userid INT NOT NULL,
		CONSTRAINT FK_users_citizens
		FOREIGN KEY (userid) REFERENCES Users(userid)
	);
END
GO

IF OBJECT_ID(N'dbo.CampaignManagers', N'U') IS NULL
BEGIN
    CREATE TABLE CampaignManagers (
		campaignmanagerid INT IDENTITY(1,1) PRIMARY KEY,
		bio VARCHAR(255) NOT NULL,
		pictureurl VARCHAR(255) NOT NULL,
		politicpartyid INT NOT NULL,
		CONSTRAINT FK_politicparties_campaignmanager
		FOREIGN KEY (politicpartyid) REFERENCES PoliticParties(politicpartyid),
		userid INT NOT NULL,
		CONSTRAINT FK_users_campaignmanagers
		FOREIGN KEY (userid) REFERENCES Users(userid)
	);
END
GO

IF OBJECT_ID(N'dbo.Actions', N'U') IS NULL
BEGIN
    CREATE TABLE Actions (
		actionid INT IDENTITY(1,1) PRIMARY KEY,
		politicpartyid INT NOT NULL
		CONSTRAINT FK_politicparties_actions
		FOREIGN KEY (politicpartyid) REFERENCES PoliticParties(politicpartyid),
		action VARCHAR(1022) NOT NULL,
		posttime DATE NOT NULL DEFAULT GETDATE(),
		deleted BIT NOT NULL DEFAULT 0,
		enabled BIT NOT NULL DEFAULT 1
	);
END
GO

IF OBJECT_ID(N'dbo.Deliverables', N'U') IS NULL
BEGIN
	CREATE TABLE Deliverables (
		deliverableid INT IDENTITY(1,1) PRIMARY KEY,
		actionId INT NOT NULL,
		CONSTRAINT FK_actions_deliverables
		FOREIGN KEY (actionId) REFERENCES Actions(actionId),
		politicPartyId INT NOT NULL,
		CONSTRAINT FK_politicParties_deliverables
		FOREIGN KEY (politicPartyId) REFERENCES PoliticParties(politicPartyId),
		name VARCHAR(63) NOT NULL,
		rate DECIMAL(3,2) NOT NULL DEFAULT 0.00,
		date DATE NOT NULL,
		posttime DATE NOT NULL DEFAULT GETDATE(),
		deleted BIT NOT NULL DEFAULT 0,
		enabled BIT NOT NULL DEFAULT 1
	);
END
GO

IF OBJECT_ID(N'dbo.Cantons', N'U') IS NULL
BEGIN
	CREATE TABLE Cantons (
		cantonid INT IDENTITY(1,1) PRIMARY KEY,
		name VARCHAR(63) NOT NULL,
		cantonlocation GEOGRAPHY DEFAULT NULL,
		politicPartiesSupport INT NOT NULL DEFAULT 0,
		deliverables INT NOT NULL DEFAULT 0
	);
END
GO

IF OBJECT_ID(N'dbo.KPIs', N'U') IS NULL
BEGIN
	CREATE TABLE KPIs (
		kpiid INT IDENTITY(1,1) PRIMARY KEY,
		kpivalue INT,
		measurement VARCHAR(63)
	);
END
GO

IF OBJECT_ID(N'dbo.CantonsXDeliverables', N'U') IS NULL
BEGIN
	CREATE TABLE CantonsXDeliverables (
		cantonid INT NOT NULL,
		CONSTRAINT FK_cantons_cantonsxdeliverables
		FOREIGN KEY (cantonid) REFERENCES Cantons(cantonid),
		deliverableid INT NOT NULL,
		CONSTRAINT FK_deliverables_cantonsxdeliverables
		FOREIGN KEY (deliverableid) REFERENCES Cantons(deliverableid)
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
