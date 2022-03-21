-- Database Structures Creation
IF NOT EXISTS ( SELECT name FROM master.dbo.sysdatabases 
                WHERE name = N'Case_2' )
BEGIN
    CREATE DATABASE Case_2;
END
GO

USE [Case_2];
GO

-- FK constraint format name is FK_targetTableName_sourceTableName

IF OBJECT_ID(N'dbo.PoliticParties', N'U') IS NULL
BEGIN
    CREATE TABLE PoliticParties (
		politicpartyid INT IDENTITY(1,1) PRIMARY KEY,
		name VARCHAR(63) NOT NULL,
		flagpictureurl VARCHAR(255) NOT NULL,
		posttime DATE NOT NULL DEFAULT GETDATE(),
		deleted BIT NOT NULL DEFAULT 0,
		enabled BIT NOT NULL DEFAULT 1
	);
END

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

IF OBJECT_ID(N'dbo.Cantons', N'U') IS NULL
BEGIN
	CREATE TABLE Cantons (
		cantonid INT IDENTITY(1,1) PRIMARY KEY,
		name VARCHAR(63) NOT NULL,
		cantonlocation GEOGRAPHY DEFAULT NULL,
		politicPartiesSupport INT NOT NULL DEFAULT 0,
		deliverables INT NOT NULL DEFAULT 0,
		posttime DATE NOT NULL DEFAULT GETDATE(),
		deleted BIT NOT NULL DEFAULT 0,
		enabled BIT NOT NULL DEFAULT 1
	);
END

IF OBJECT_ID(N'dbo.Citizens', N'U') IS NULL
BEGIN
    CREATE TABLE Citizens (
		citizenid INT IDENTITY(1,1) PRIMARY KEY,
		userid INT NOT NULL,
		CONSTRAINT FK_users_citizens
		FOREIGN KEY (userid) REFERENCES Users(userid),
		citizenlocation GEOGRAPHY DEFAULT NULL
	);
END

IF OBJECT_ID(N'dbo.CitizensXCantons', N'U') IS NULL
BEGIN
	CREATE TABLE CitizensXCantons (
		citizenid INT NOT NULL,
		CONSTRAINT FK_citizens_citizensxcantons
		FOREIGN KEY (citizenid) REFERENCES Citizens(citizenid),
		cantonid INT NOT NULL,
		CONSTRAINT FK_cantons_citizensxcantons
		FOREIGN KEY (cantonid) REFERENCES Cantons(cantonid),
	);
END

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

IF OBJECT_ID(N'dbo.Actions', N'U') IS NULL
BEGIN
    CREATE TABLE Actions (
		actionid INT IDENTITY(1,1) PRIMARY KEY,
		politicpartyid INT NOT NULL,
		CONSTRAINT FK_politicparties_actions
		FOREIGN KEY (politicpartyid) REFERENCES PoliticParties(politicpartyid),
		action VARCHAR(1022) NOT NULL,
		posttime DATE NOT NULL DEFAULT GETDATE(),
		deleted BIT NOT NULL DEFAULT 0,
		enabled BIT NOT NULL DEFAULT 1
	);
END

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

IF OBJECT_ID(N'dbo.KPIs', N'U') IS NULL
BEGIN
	CREATE TABLE KPIs (
		kpiid INT IDENTITY(1,1) PRIMARY KEY,
		kpivalue INT,
		measurement VARCHAR(63),
		posttime DATE NOT NULL DEFAULT GETDATE(),
		deleted BIT NOT NULL DEFAULT 0,
		enabled BIT NOT NULL DEFAULT 1
	);
END

IF OBJECT_ID(N'dbo.CantonsXDeliverables', N'U') IS NULL
BEGIN
	CREATE TABLE CantonsXDeliverables (
		cantonid INT NOT NULL,
		CONSTRAINT FK_cantons_cantonsxdeliverables
		FOREIGN KEY (cantonid) REFERENCES Cantons(cantonid),
		deliverableid INT NOT NULL,
		CONSTRAINT FK_deliverables_cantonsxdeliverables
		FOREIGN KEY (deliverableid) REFERENCES Deliverables(deliverableid),
		kpiid INT NOT NULL,
		CONSTRAINT FK_kpis_cantonsxdeliverables
		FOREIGN KEY (kpiid) REFERENCES KPIs(kpiid)

	);
END

-- Database Tables Population

IF NOT EXISTS( SELECT politicpartyid FROM [dbo].[PoliticParties])
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

IF NOT EXISTS( SELECT userid FROM [dbo].[Users] )
BEGIN
    INSERT INTO [dbo].[Users] (firstname, secondname, lastname, idcard)
    VALUES
           --Campaign Manager Users
        ('Juan', 'Carlos', 'Mora', '154780945'),
        ('Andrea', 'Pamela', 'Hidalgo', '908740635'),
           --Campaign Manager and Citizen Users
        ('Ximena', 'Brillit', 'Newball', '70698244'),
        ('Jose', 'Maria', 'Alvarez', '985476241'),
           --Citizens Users
        ('Dylan', '', 'Gonzalez', '846147846'),
        ('Luis', 'Diego', 'Aguilar', '367545512'),
        ('Eliza', 'Angelica', 'Schyler', '146569374'),
        ('Rodrigo', 'Alonso', 'Trejos', '764319788')
END

IF NOT EXISTS( SELECT roleid FROM [dbo].[Roles] )
BEGIN
    INSERT INTO [dbo].[Roles] (rolename)
    VALUES
        ('Citizen'),
        ('Campaign Manager')
END

IF NOT EXISTS( SELECT userid FROM [dbo].[UsersXRoles] )
BEGIN
    INSERT INTO [dbo].[UsersXRoles] (roleid, userid)
    VALUES
           (2, 1),      --Juan CM
           (2, 2),      --Andrea CM
           (2, 3),      --Ximena CM  ****
           (2, 4),      --Jose CM    ****
           (1, 3),      --Ximena also Citizen  ****
           (1, 4),      --Jose also Citizen    ****
           (1, 5),      --Dylan Citizen
           (1, 6),      --Luis Citizen
           (1, 7),      --Eliza Citizen
           (1, 8)       --Rodrigo Citizen
END

IF NOT EXISTS( SELECT campaignmanagerid FROM [dbo].[CampaignManagers])
BEGIN
	INSERT INTO [dbo].[CampaignManagers] (bio, pictureurl, politicpartyid, userid)
	VALUES 
		('Doctor en Economia y politica',
		'https://i.ibb.co/7SkKYsV/PAC.png',
		1,
		1),
		('Doctor en AgroIndustria',
		'https://i.ibb.co/GQS3FfH/CD-500.png',
		2,
		2),
		('Agricultor',
		'https://i.ibb.co/84k30Yv/Partido-Liberal-Radical-Autentico-svg.png',
		3,
		3),
		('Licenciado Abogado',
		'https://i.ibb.co/tzhKTmM/Bandera-Partido-Restauraci-n-Nacional-Costa-Rica-2022-svg.png',
		4,
		4)
END

IF NOT EXISTS( SELECT userid FROM [dbo].[Citizens])
BEGIN
	INSERT INTO [dbo].[Citizens] (userid)
	VALUES
		(3), (4), (5), (6), (7), (8)
END

IF NOT EXISTS( SELECT actionid FROM [dbo].[Actions])
BEGIN
	-- PAC
	INSERT INTO [dbo].[Actions] (politicPartyId, action)
	VALUES
		(1, 'Reparar calles dañadas, restaurar calles en mal estado'),
		(1, 'Aumentar la seguridad ciudadana'),
		(1, 'Generar mas empleos'),
        (1, 'Generar mas donas'),
		(2, 'Reparar calles dañadas, restaurar calles en mal estado'),
		(2, 'Eliminar la corrupcion de la politica'),
		(2, 'Mejora del medio ambiente'),
	    (2, 'Mejora del tendido electrico'),
		(3, 'Mejora en la educacion'),
		(3, 'Implementacion del tren electrico'),
		(3, 'Incorporacion de Buses biodegradables y electricos'),
	    (3, 'Inclusividad para personas discapacitadas'),
		(4, 'Uso de energias renovables al 90% en todo el pais'),
		(4, 'Acceso a Internet a 90% en todo el pais'),
		(4, 'Eliminacion de la Analfabetizacion'),
		(4, 'Eliminacion del phising de internet'),
        (4, 'Incorporacion del sistema virtual en control de auditorias de impuestos')
END

IF NOT EXISTS( SELECT cantonid FROM [dbo].[Cantons])
BEGIN
	INSERT INTO [dbo].[Cantons] (name)
	VALUES
	        ( 'Abangares' ),
	        ( 'Acosta (San José, CR)' ),
	        ( 'Alajuela (Alajuela, CR)' ),
	        ( 'Alajuelita (San José, CR)' ),
	        ( 'Alvarado (Cartago, CR)' ),
	        ( 'Aserrí (San José, CR)' ),
	        ( 'Atenas (Alajuela, CR)' ),
            ( 'Bagaces (Guanacaste, CR)' ),
	        ( 'Barva (Heredia, CR)' ),
	        ( 'Belén (Heredia, CR)' ),
	        ( 'Buenos Aires (Puntarenas, CR)' ),
	        ( 'Cañas (Guanacaste, CR)' ),
	        ( 'Carrillo (Guanacaste, CR)' ),
	        ( 'Cartago (Cartago, CR)' ),
	        ( 'Corredores (Puntarenas, CR)' ),
	        ( 'Coto Brus (Puntarenas, CR)' ),
	        ( 'Curridabat (San José, CR)' )
END

IF NOT EXISTS( SELECT citizenid FROM [dbo].[CitizensXCantons])
BEGIN
	INSERT INTO [dbo].[CitizensXCantons] (citizenid, cantonid)
	SELECT citizenid,
	       (SELECT TOP 1 cantonid FROM Cantons ORDER BY NEWID())
	FROM Citizens
END

IF NOT EXISTS( SELECT kpiid FROM [dbo].[KPIs])
BEGIN
    INSERT INTO KPIs (kpivalue, measurement)
    VALUES
        (20,'Kilometros'),
        (10, 'Votos de aprobacion'),
        (5, 'Litros'),
        (100, 'Porcentaje de poblacion'),
        (30, 'Horas semanales'),
        (5, 'Estrellas de satisfaccion'),
        (67, 'Ganancia neta por dia'),
        (43, 'Avance semanal')
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

DECLARE @quantitypoliticparties INT
DECLARE @quantityactions INT
DECLARE @quantitydeliverables INT
DECLARE @politicpartyid INT
DECLARE @actionid INT
DECLARE @cantonid INT
DECLARE @deliv_name VARCHAR(63)
DECLARE @kpiid INT
DECLARE @LOCAL_CantonsSupported TABLE (cantonid INT)

SELECT @quantitypoliticparties = COUNT(politicpartyid) FROM dbo.PoliticParties
SELECT @quantityactions = COUNT(actionid) FROM dbo.Actions
SET @politicpartyid = 1
-- For each politic party
WHILE @politicpartyid <= @quantitypoliticparties
BEGIN
	SET @actionid = 1
	-- For each Action of that Politic party
	WHILE @actionid <= @quantityactions
	BEGIN
	-- Random between 4 and 10 | x belongs to [4,11[
	--PD: This change has been made due to the 40% deliverables raise requested
		SELECT @quantitydeliverables = RAND()*(11-4)+4;
		-- For each Deliverable for each Action for each Politic Party
		WHILE @quantitydeliverables > 0
		BEGIN
			IF RAND() > 0.5 BEGIN
				-- Pick random id from ids in Cantons table
				SELECT TOP 1 @cantonid = cantonid FROM dbo.Cantons ORDER BY NEWID()
			END ELSE BEGIN
			    -- The 50% of the times it will choose any id from 1 to 11, just to make variation
				SELECT @cantonid = RAND()*(12-1)+1;
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
			SELECT TOP 1 @kpiid = kpiid FROM KPIs ORDER BY NEWID()
			INSERT INTO dbo.CantonsXDeliverables(cantonId, deliverableId, kpiid)
			VALUES (@cantonid,
					IDENT_CURRENT('Deliverables'),
					@kpiid)
		    --Raises the deliverables for a canton
			UPDATE Cantons
				SET deliverables = deliverables + 1
			WHERE cantonid = @cantonid
			--Checks if this politicParty is already supporting the current canton
			IF NOT EXISTS (SELECT cantonid FROM @LOCAL_CantonsSupported as cs
						WHERE cs.cantonid = @cantonid)
			BEGIN
				UPDATE Cantons
					SET politicPartiesSupport = politicPartiesSupport + 1
				WHERE cantonid = @cantonid
				INSERT INTO @LOCAL_CantonsSupported(cantonid) VALUES (@cantonid)
			END
			SET @quantitydeliverables =  @quantitydeliverables - 1
		END
		SET @actionid = @actionid + 1
	END
	SET @politicpartyid = @politicpartyid + 1
	DELETE @LOCAL_CantonsSupported
END

SELECT * FROM PoliticParties
SELECT * FROM Users
SELECT * FROM UsersXRoles
SELECT * FROM Roles
SELECT * FROM CampaignManagers
SELECT * FROM Citizens
SELECT * FROM CitizensXCantons
SELECT * FROM Cantons
SELECT * FROM Actions
SELECT * FROM Deliverables
SELECT * FROM CantonsXDeliverables
SELECT * FROM KPIs

--Sql StoredProcedures

---- Endpoint 1
SELECT C.name, COUNT(D.deliverableid) FROM Cantons C
INNER JOIN CantonsXDeliverables CD
ON CD.cantonId = C.cantonid
INNER JOIN Deliverables D
ON D.deliverableid = CD.deliverableid
WHERE (DATEDIFF(DAY, '03/07.2022', D.date) <= 100)
EXCEPT
SELECT C.name, COUNT(D.deliverableid) FROM Cantons C
INNER JOIN CantonsXDeliverables CD
ON CD.cantonId = C.cantonid
INNER JOIN Deliverables D	
ON D.deliverableid = CD.deliverableid
WHERE (DATEDIFF(DAY, DATEADD(DAY, '03/07.2022', 700), D.date) <= 100) AND COUNT(D.deliverableid) != 0 -- ocupa mejora \\

---- Endpoint 2
DECLARE @pAccion INT;
DECLARE @pPartido INT;

--SELECT PT.Partido, PT.ActionID, PT.PrimerTercio, PT.SegundoTercio, PT.TercerTercio FROM (
--	SELECT P.id,
--		   A.id as ActionID, 
--		   C.name,
--		   P.name as Partido
--	FROM Cantons C
--	INNER JOIN Actions A
--	ON A.id = @pAccion
--	INNER JOIN PoliticParties P
--	ON P.id = @pPartido
--) DensidadCanton
--PIVOT (
--	COUNT(ActionID)
--	FOR Cantons
--	IN (
--		[PrimerTercio],
--		[SegundoTercio],
--		[TercerTercio]
--	)
--) AS PT

SELECT [name], [action], Tercio1, Tercio2, Tercio3 FROM 
	(SELECT P.[name], A.[action], D.rate,
		'Tercio' + CAST(DENSE_RANK() OVER(ORDER BY CASE
											WHEN D.rate <= 33 THEN 1
											WHEN D.rate <= 66 THEN 2
											WHEN D.rate <= 100 THEN 3
											END ASC) AS VARCHAR(16)) AS RANGO
	FROM PoliticParties P
		INNER JOIN Actions A
		ON A.politicpartyid = P.politicpartyid
		INNER JOIN Deliverables D
		ON D.politicPartyId = P.politicpartyid
		INNER JOIN CantonsXDeliverables CD
		ON CD.deliverableid = D.deliverableid
		INNER JOIN Cantons C
		ON C.cantonid = CD.cantonid
	) AS RANGETABLE
	PIVOT
	(
		COUNT(D.rate)
		FOR RANGO IN 
		( [Tercio1], [Tercio2], [Tercio3]
		)
	) AS PIVOTABLE

-- Endpoint 3

DECLARE @pEntrada VARCHAR(16);

--SELECT [name], COUNT(deliverableId), [rank]
--FROM 
--  ( SELECT PP.[name], COUNT(deliverableId),
--           RANK() OVER (PARTITION BY [name]
--                              ORDER BY DATEPART(MONTH, D.[date]) DESC
--                             )
--             AS [rank]
--    FROM PoliticParties PP
--	INNER JOIN Deliverables D
--	ON D.politicPartyId = PP.politicPartyId
--  ) tmp 
--WHERE [rank] <= 3 AND CONTAINS(D.[name], @pEntrada)
--ORDER BY [name], [rank] ; 

--SELECT * 
--	FROM
--	(SELECT	P.[name], [year], [month], percent)


-- Endpoint 4



-- Endpoint 5



-- Endpoint 6


