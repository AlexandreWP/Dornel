
USE [BancoF2]
GO

DROP TABLE [dbo].[Circuito]
DROP TABLE [dbo].[equipeResult]
DROP TABLE [dbo].[equipe]
DROP TABLE [dbo].[equipeClassif]
DROP TABLE [dbo].[piloto]
DROP TABLE [dbo].[pilotoClassif]
DROP TABLE [dbo].[tempoVolta]
DROP TABLE [dbo].[pitStops]
DROP TABLE [dbo].[qualificacao]
DROP TABLE [dbo].[corrida]
DROP TABLE [dbo].[resultado]
--DROP TABLE [dbo].[temporada]
DROP TABLE [dbo].[status]

CREATE TABLE [dbo].[Circuito](
	[circId] [int] IDENTITY NOT NULL,
	[circAbrev] [varchar](50) NULL,
	[circNome] [varchar](50) NULL,
	[cidade] [varchar](50) NULL,
	[pais] [varchar](50) NULL,
	[lat] [varchar](50) NULL,
	[lng] [varchar](50) NULL
	CONSTRAINT PK_Circuito PRIMARY KEY CLUSTERED (circId)
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Corrida](
	[corridaId] [int] IDENTITY NOT NULL,
	[ano] [varchar](50) NULL,
	[rodada] [varchar](50) NULL,
	[circId] [int] NOT NULL,
	[data] [varchar](50) NULL,
	[hora] [varchar](50) NULL
	CONSTRAINT PK_Corrida PRIMARY KEY CLUSTERED (corridaId)
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Equipe](
	[equipId] [int] IDENTITY NOT NULL,
	[Nome] [varchar](50) NULL,
	[pais] [varchar](255) NULL
	CONSTRAINT PK_Equipe PRIMARY KEY CLUSTERED (equipId)
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[EquipeResult](
	[equipResId] [int] IDENTITY NOT NULL,
	[corridaId] [int] NOT NULL,
	[equipId] [int] NOT NULL,
	[pontos] [varchar](50) NULL
	CONSTRAINT PK_EquipeResult PRIMARY KEY CLUSTERED (equipResId)
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[EquipeClassif](
	[equipClassId] [int] IDENTITY NOT NULL,
	[corridaId] [int] NOT NULL,
	[equipId] [int] NOT NULL,
	[pontos] [varchar](50) NULL,
	[posicao] [varchar](50) NULL,
	[vitoria] [varchar](50) NULL
	CONSTRAINT PK_EquipeClassif PRIMARY KEY CLUSTERED (equipClassId)
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Piloto](
	[pilotId] [int] IDENTITY NOT NULL,
	[numero] [varchar](50) NULL,
	[pilotAbrv] [varchar](50) NULL,
	[pilotNome] [varchar](50) NULL,
	[sobrenome] [varchar](50) NULL,
	[sexo][char](1) NOT NULL,
	[dataNasc] [varchar](50) NULL,
	[nascionald] [varchar](50) NULL
	CONSTRAINT PK_Piloto PRIMARY KEY CLUSTERED (pilotId)
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[PilotoClassif](
	[pilotClassId] [int] IDENTITY NOT NULL,
	[corridaId] [int]  NOT NULL,
	[pilotId] [int] NOT NULL,
	[ponto] [varchar](50) NULL,
	[posicao] [varchar](50) NULL,
	[vitoria] [varchar](50) NULL
	CONSTRAINT PK_PilotoClassif PRIMARY KEY CLUSTERED (pilotClassId)
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[TempoVolta](
	[corridaId] [int] NOT NULL,
	[pilotId] [int] NOT NULL,
	[volta] [varchar](50) NULL,
	[posicao] [varchar](50) NULL,
	[tempo] [varchar](50) NULL,
	[milesegundo] [varchar](50) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[PitStops](
	[corridaId] [int] NOT NULL,
	[pilotId] [int] NOT NULL,
	[parada] [varchar](50) NULL,
	[volta] [varchar](50) NULL,
	[tempo] [varchar](50) NULL,
	[duracao] [varchar](50) NULL,
	[milesegundo] [varchar](50) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Qualificacao](
	[qualifId] [int] IDENTITY NOT NULL,
	[corridaId] [int] NOT NULL,
	[pilotId] [int] NOT NULL,
	[equipId] [int] NOT NULL,
	[numero] [int] NULL,
	[posicao] [varchar](50) NULL,
	[q1] [varchar](50) NULL,
	[q2] [varchar](50) NULL,
	[q3] [varchar](50) NULL
	CONSTRAINT PK_Qualific PRIMARY KEY CLUSTERED (qualifId)
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Resultado](
	[resultId] [int] IDENTITY NOT NULL,
	[corridaId] [int] NOT NULL,
	[pilotId] [int] NOT NULL,
	[equipId] [int] NOT NULL,
	[numero] [int] NULL,
	[grid] [varchar](50) NULL,
	[posicao] [varchar](50) NULL,
	[posicaoText] [varchar](50) NULL,
	[posicaoOrder] [varchar](50) NULL,
	[pontos] [varchar](50) NULL,
	[voltas] [varchar](50) NULL,
	[tempo] [varchar](50) NULL,
	[milesegundo] [varchar](50) NULL,
	[voltaRapida] [varchar](50) NULL,
	[velocidadeMax] [varchar](50) NULL,
	[statusId] [varchar](50) NULL
	CONSTRAINT PK_Result PRIMARY KEY CLUSTERED (resultId)
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Temporada](
	[ano] [varchar](255) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Status](
	[statusId] [int] IDENTITY NOT NULL,
	[status] [varchar](50) NULL
	CONSTRAINT PK_Status PRIMARY KEY CLUSTERED (statusId)
) ON [PRIMARY]

GO

--INSERÇÃO DOS DADOS
INSERT INTO [dbo].[Circuito](
	[circAbrev],
	[circNome],
	[cidade],
	[pais],
	[lat],
	[lng])
SELECT [circuitRef]
      ,[name]
      ,[location]
      ,[country]
      ,[lat]
      ,[lng]
  FROM [Teste].[dbo].[circuits3]
GO

INSERT INTO [dbo].[corrida](
	[ano],
	[rodada],
	[circId],
	[data],
	[hora])
SELECT [year]
      ,[round]
      ,[circuitId]
      ,[date]
      ,[time]
  FROM [Teste].[dbo].[races]
GO

INSERT INTO [dbo].[equipeResult](
	[corridaId],
	[equipId],
	[pontos])
SELECT [raceId]
      ,[constructorId]
      ,[points]
  FROM [Teste].[dbo].[constructorResults]
GO

INSERT INTO [dbo].[equipe](
	[Nome],
	[pais])
SELECT [name]
      ,[nationality]
  FROM [Teste].[dbo].[constructors]
GO

INSERT INTO [dbo].[equipeClassif](
	[corridaId],
	[equipId],
	[pontos],
	[posicao],
	[vitoria])
SELECT [raceId]
      ,[constructorId]
      ,[points]
      ,[position]
      ,[wins]
  FROM [Teste].[dbo].[constructorStandings]
GO

INSERT INTO [dbo].[piloto](
	[numero],
	[pilotAbrv],
	[pilotNome],
	[sobrenome],
	[sexo],
	[dataNasc],
	[nascionald])
SELECT [number]
      ,[code]
      ,[forename]
      ,[surname]
	  ,CASE WHEN forename LIKE '%A' THEN 'F' ELSE 'M' END
      ,[dob]
      ,[nationality]
  FROM [Teste].[dbo].[drivers]
GO

INSERT INTO [dbo].[pilotoClassif]([corridaId],
	[pilotId],
	[ponto],
	[posicao],
	[vitoria])
SELECT [raceId]
      ,[driverId]
      ,[points]
      ,[position]
      ,[wins]
  FROM [Teste].[dbo].[driverStandings]
GO

INSERT INTO [dbo].[tempoVolta](
	[corridaId],
	[pilotId],
	[volta],
	[posicao],
	[tempo],
	[milesegundo])
SELECT [raceId]
      ,[driverId]
      ,[lap]
      ,[position]
      ,[time]
      ,[milliseconds]
  FROM [Teste].[dbo].[lapTimes]
GO

INSERT INTO [dbo].[pitStops](
	[corridaId],
	[pilotId],
	[parada],
	[volta],
	[tempo],
	[duracao],
	[milesegundo])
SELECT [raceId]
      ,[driverId]
      ,[stop]
      ,[lap]
      ,[time]
      ,[duration]
      ,[milliseconds]
  FROM [Teste].[dbo].[pitStops]
GO

INSERT INTO [dbo].[qualificacao](
	[corridaId],
	[pilotId],
	[equipId],
	[numero],
	[posicao],
	[q1],
	[q2],
	[q3])
SELECT [raceId]
      ,[driverId]
      ,[constructorId]
      ,[number]
      ,[position]
      ,[q1]
      ,[q2]
      ,[q3]
  FROM [Teste].[dbo].[qualifying]
GO

INSERT INTO [dbo].[resultado](
	[corridaId],
	[pilotId],
	[equipId],
	[numero],
	[grid],
	[posicao],
	[posicaoText],
	[posicaoOrder],
	[pontos],
	[voltas],
	[tempo],
	[milesegundo],
	[voltaRapida],
	[velocidadeMax],
	[statusId])
SELECT [raceId]
      ,[driverId]
      ,[constructorId]
      ,[number]
      ,[grid]
      ,[position]
      ,[positionText]
      ,[positionOrder]
      ,[points]
      ,[laps]
      ,[time]
      ,[milliseconds]
      ,[fastestLapTime]
      ,[fastestLapSpeed]
      ,[statusId]
  FROM [Teste].[dbo].[results]
GO

INSERT INTO [dbo].[temporada](
	[ano])
SELECT [year]
  FROM [Teste].[dbo].[seasons2]
GO

INSERT INTO [dbo].[status](
	[status])
SELECT [status]
  FROM [Teste].[dbo].[status]
GO



--Ajustes
UPDATE dbo.Circuito SET pais = 'Bélgica' WHERE pais = 'Belgium'
UPDATE dbo.Circuito SET pais = 'Azerbaijão' WHERE pais = 'Azerbaijan'
UPDATE dbo.Circuito SET pais = 'Brasil' WHERE pais = 'Brazil'
UPDATE dbo.Circuito SET pais = 'Canadá' WHERE pais = 'Canada'
UPDATE dbo.Circuito SET pais = 'França' WHERE pais = 'France'
UPDATE dbo.Circuito SET pais = 'Alemanha' WHERE pais = 'Germany'
UPDATE dbo.Circuito SET pais = 'Hungria' WHERE pais = 'Hungary'
UPDATE dbo.Circuito SET pais = 'Índia' WHERE pais = 'India'
UPDATE dbo.Circuito SET pais = 'Itália' WHERE pais = 'Italy'
UPDATE dbo.Circuito SET pais = 'Japão' WHERE pais = 'Japan'
UPDATE dbo.Circuito SET pais = 'Coréia do Sul' WHERE pais = 'Korea'
UPDATE dbo.Circuito SET pais = 'Malásia' WHERE pais = 'Malaysia'
UPDATE dbo.Circuito SET pais = 'México' WHERE pais = 'Mexico'
UPDATE dbo.Circuito SET pais = 'Monâco' WHERE pais = 'Monaco'
UPDATE dbo.Circuito SET pais = 'Marrocos' WHERE pais = 'Marocco'
UPDATE dbo.Circuito SET pais = 'Holanda' WHERE pais = 'Netherlands'
UPDATE dbo.Circuito SET pais = 'Cingapura' WHERE pais = 'Singapore'
UPDATE dbo.Circuito SET pais = 'África do Sul' WHERE pais = 'South Africa'
UPDATE dbo.Circuito SET pais = 'Espanha' WHERE pais = 'Spain'
UPDATE dbo.Circuito SET pais = 'Suécia' WHERE pais = 'Sweden'
UPDATE dbo.Circuito SET pais = 'Suíça' WHERE pais = 'Switzerland'
UPDATE dbo.Circuito SET pais = 'Túrquia' WHERE pais = 'Turkey'
UPDATE dbo.Circuito SET pais = 'Inglaterra' WHERE pais = 'UK'
UPDATE dbo.Circuito SET pais = 'Estados Unidos' WHERE pais = 'USA'
UPDATE dbo.Circuito SET pais = 'Emirados Árabes' WHERE pais = 'UAE'
UPDATE dbo.Circuito SET pais = 'Rússia' WHERE pais = 'Russia'
UPDATE dbo.Circuito SET cidade = 'São Paulo' WHERE cidade = 'SÌ£o Paulo'
UPDATE dbo.Circuito SET cidade = 'Lisboa' WHERE cidade = 'Lisbon'
UPDATE dbo.Circuito SET cidade = 'Cidade do México' WHERE cidade = 'Mexico City'
UPDATE dbo.Circuito SET cidade = 'Berlim' WHERE cidade = 'Berlin'
UPDATE dbo.Circuito SET cidade = 'Montmeló' WHERE cidade = 'MontmelÌ_'
UPDATE dbo.Circuito SET cidade = 'Nürburg' WHERE cidade = 'NÌ_rburg'

UPDATE dbo.Equipe SET pais = 'Estados Unidos' WHERE pais LIKE 'American%'
UPDATE dbo.Equipe SET pais = 'Australia' WHERE pais LIKE 'Australian%'
UPDATE dbo.Equipe SET pais = 'Austria' WHERE pais LIKE 'Austrian%'
UPDATE dbo.Equipe SET pais = 'Bélgica' WHERE pais LIKE 'Belgium%'
UPDATE dbo.Equipe SET pais = 'Brasil' WHERE pais LIKE 'Brazilian%'
UPDATE dbo.Equipe SET pais = 'Inglaterra' WHERE pais LIKE 'British%'
UPDATE dbo.Equipe SET pais = 'Canadá' WHERE pais LIKE 'Canadian%'
UPDATE dbo.Equipe SET pais = 'Alemanha' WHERE pais LIKE 'German%' Or pais LIKE 'East%'
UPDATE dbo.Equipe SET pais = 'França' WHERE pais LIKE 'French%'
UPDATE dbo.Equipe SET pais = 'Holanda' WHERE pais LIKE 'Dutch%'
UPDATE dbo.Equipe SET pais = 'Estados Unidos' WHERE pais LIKE 'American%'
UPDATE dbo.Equipe SET pais = 'Hong Kong' WHERE pais LIKE 'Hong%'
UPDATE dbo.Equipe SET pais = 'Índia' WHERE pais LIKE 'Indian%'
UPDATE dbo.Equipe SET pais = 'Irlanda' WHERE pais LIKE 'Irish%'
UPDATE dbo.Equipe SET pais = 'Itália' WHERE pais LIKE 'Italian%'
UPDATE dbo.Equipe SET pais = 'Japão' WHERE pais LIKE 'Japanese%'
UPDATE dbo.Equipe SET pais = 'Málasia' WHERE pais LIKE 'Malaysian%'
UPDATE dbo.Equipe SET pais = 'México' WHERE pais LIKE 'Mexican%'
UPDATE dbo.Equipe SET pais = 'Nova Zelândia' WHERE pais LIKE 'New%'
UPDATE dbo.Equipe SET pais = 'Zimbuabue' WHERE pais LIKE 'Rhodesian%'
UPDATE dbo.Equipe SET pais = 'Rússia' WHERE pais LIKE 'Russian%'
UPDATE dbo.Equipe SET pais = 'África do Sul' WHERE pais LIKE 'South%'
UPDATE dbo.Equipe SET pais = 'Espanha' WHERE pais LIKE 'Spanish%'
UPDATE dbo.Equipe SET pais = 'Suiça' WHERE pais LIKE 'Swiss%'

UPDATE dbo.Piloto SET nascionald = 'Americano' WHERE nascionald LIKE 'American%'
UPDATE dbo.Piloto SET nascionald = 'Argentino' WHERE nascionald LIKE 'Argentine%'
UPDATE dbo.Piloto SET nascionald = 'Australiano' WHERE nascionald LIKE 'Australian%'
UPDATE dbo.Piloto SET nascionald = 'Austriaco' WHERE nascionald LIKE 'Austrian%'
UPDATE dbo.Piloto SET nascionald = 'Bélgico' WHERE nascionald LIKE 'Belgian%'
UPDATE dbo.Piloto SET nascionald = 'Brasileiro' WHERE nascionald LIKE 'Brazilian%'
UPDATE dbo.Piloto SET nascionald = 'Britânico' WHERE nascionald LIKE 'British%'
UPDATE dbo.Piloto SET nascionald = 'Canadense' WHERE nascionald LIKE 'Canadian%'
UPDATE dbo.Piloto SET nascionald = 'Chileno' WHERE nascionald LIKE 'Chilean%'
UPDATE dbo.Piloto SET nascionald = 'Tcheco' WHERE nascionald LIKE 'Czech%'
UPDATE dbo.Piloto SET nascionald = 'Dinamarquês' WHERE nascionald LIKE 'Danish%'
UPDATE dbo.Piloto SET nascionald = 'Holandês' WHERE nascionald LIKE 'Dutch%'
UPDATE dbo.Piloto SET nascionald = 'Alemão' WHERE nascionald LIKE 'East%' OR nascionald LIKE 'German%'
UPDATE dbo.Piloto SET nascionald = 'Finlandês' WHERE nascionald LIKE 'Finnish%'
UPDATE dbo.Piloto SET nascionald = 'Francês' WHERE nascionald LIKE 'French%'
UPDATE dbo.Piloto SET nascionald = 'Hungaro' WHERE nascionald LIKE 'Hunga%'
UPDATE dbo.Piloto SET nascionald = 'Indiano' WHERE nascionald LIKE 'Indian%'
UPDATE dbo.Piloto SET nascionald = 'Indonésio' WHERE nascionald LIKE 'Indonesian%'
UPDATE dbo.Piloto SET nascionald = 'Irlandês' WHERE nascionald LIKE 'Irish%'
UPDATE dbo.Piloto SET nascionald = 'Italiano' WHERE nascionald LIKE 'Italian%'
UPDATE dbo.Piloto SET nascionald = 'Japonês' WHERE nascionald LIKE 'Japanese%'
UPDATE dbo.Piloto SET nascionald = 'Liechtensteiniense' WHERE nascionald LIKE 'Liechte%'
UPDATE dbo.Piloto SET nascionald = 'Malásio' WHERE nascionald LIKE 'Malaysian%'
UPDATE dbo.Piloto SET nascionald = 'Mexicano' WHERE nascionald LIKE 'Mexican%'
UPDATE dbo.Piloto SET nascionald = 'Monegasca' WHERE nascionald LIKE 'Monegas%'

SELECT DISTINCT [pais]
INTO DWFormula1.DBO.DimPais FROM [BancoF2].[dbo].[Circuito]

SELECT DISTINCT [cidade]
INTO DWFormula1.DBO.DimCidade FROM [BancoF2].[dbo].[Circuito]

SELECT DISTINCT [nascionald]
INTO DWFormula1.DBO.DimNacional FROM [BancoF2].[dbo].[Piloto]

ALTER TABLE DWFormula1.DBO.DimPais ADD paisId int IDENTITY
ALTER TABLE DWFormula1.DBO.DimCidade ADD cidadeId int IDENTITY
ALTER TABLE DWFormula1.DBO.DimNacional ADD nacId int IDENTITY


SELECT CR1.corridaId, C2.circId, PC1.pilotClassId, P1.pilotId, EQ.equipId, 
RES.resultId, EQCL.equipClassId, EQRE.equipResId, Q1.qualifId
INTO DWFormula1.DBO.DwFatos FROM [BancoF2].[dbo].[Resultado] RES
	INNER JOIN [BancoF2].[dbo].[Corrida] CR1 ON RES.corridaId = CR1.corridaId
	INNER JOIN [BancoF2].[dbo].[Piloto] P1 ON RES.pilotId = P1.pilotId
	INNER JOIN [BancoF2].[dbo].[Equipe] EQ ON RES.equipId = EQ.equipId
	INNER JOIN [BancoF2].[dbo].[Circuito] C2 ON CR1.circId = C2.circId
	INNER JOIN [BancoF2].[dbo].[PilotoClassif] PC1 ON P1.pilotId = PC1.pilotId AND CR1.corridaId = PC1.corridaId
	INNER JOIN [BancoF2].[dbo].[EquipeClassif] EQCL ON EQ.equipId = EQCL.equipId AND CR1.corridaId = EQCL.corridaId
	INNER JOIN [BancoF2].[dbo].[EquipeResult] EQRE ON EQ.equipId = EQRE.equipId AND CR1.corridaId = EQRE.corridaId
	INNER JOIN [BancoF2].[dbo].[Qualificacao] Q1 ON CR1.corridaId = Q1.corridaId

	CREATE INDEX IX_Circuito_CircID on [Circuito] ([circId])
	UPDATE STATISTICS [Circuito]

	CREATE INDEX IX_Corrida_CircID on [Corrida] ([circId])
	UPDATE STATISTICS [Corrida]

	CREATE INDEX IX_PilotoClassif_CircID on [PilotoClassif] (corridaId)
	UPDATE STATISTICS [PilotoClassif]
		
	CREATE INDEX IX_PilotoClassif_CircID on [Piloto] (pilotId)
	UPDATE STATISTICS [Piloto]

	CREATE INDEX IX_Resultado_CircID on [Resultado] (pilotId)
	UPDATE STATISTICS [Resultado]

	CREATE INDEX IX_EquipeClassif_CircID on [EquipeClassif] (equipId)
	UPDATE STATISTICS [EquipeClassif]

	CREATE INDEX IX_EquipeResult_CircID on [EquipeResult] (equipId)
	UPDATE STATISTICS [EquipeResult]

	CREATE INDEX IX_Qualificacao_CircID on [Qualificacao] (corridaId)
	UPDATE STATISTICS [Qualificacao]

SELECT [equipId],DWP.paisId FROM [BancoF2].[dbo].[Equipe] E2 INNER JOIN DWFormula1.DBO.DimPais DWP ON E2.pais = DWP.pais

SELECT [pilotId],[nacId] FROM [BancoF2].[dbo].[Piloto] P2 INNER JOIN DWFormula1.DBO.DimNacional DWN ON P2.nascionald = DWN.nascionald
