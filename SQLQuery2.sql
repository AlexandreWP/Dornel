USE [DwFormula1]
GO

CREATE TABLE [dbo].[DwCircuito](
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

CREATE TABLE [dbo].[DwCorrida](
	[corridaId] [int] IDENTITY NOT NULL,
	[ano] [varchar](50) NULL,
	[rodada] [varchar](50) NULL,
	[circId] [int] NOT NULL,
	[data] [varchar](50) NULL,
	[hora] [varchar](50) NULL
	CONSTRAINT PK_Corrida PRIMARY KEY CLUSTERED (corridaId)
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[DwEquipe](
	[equipId] [int] IDENTITY NOT NULL,
	[Nome] [varchar](50) NULL,
	[pais] [varchar](255) NULL
	CONSTRAINT PK_Equipe PRIMARY KEY CLUSTERED (equipId)
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[DwEquipeResult](
	[equipResId] [int] IDENTITY NOT NULL,
	[corridaId] [int] NOT NULL,
	[equipId] [int] NOT NULL,
	[pontos] [varchar](50) NULL
	CONSTRAINT PK_EquipeResult PRIMARY KEY CLUSTERED (equipResId)
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[DwEquipeClassif](
	[equipClassId] [int] IDENTITY NOT NULL,
	[corridaId] [int] NOT NULL,
	[equipId] [int] NOT NULL,
	[pontos] [varchar](50) NULL,
	[posicao] [varchar](50) NULL,
	[vitoria] [varchar](50) NULL
	CONSTRAINT PK_EquipeClassif PRIMARY KEY CLUSTERED (equipClassId)
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[DwPiloto](
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

CREATE TABLE [dbo].[DwPilotoClassif](
	[pilotClassId] [int] IDENTITY NOT NULL,
	[corridaId] [int]  NOT NULL,
	[pilotId] [int] NOT NULL,
	[ponto] [varchar](50) NULL,
	[posicao] [varchar](50) NULL,
	[vitoria] [varchar](50) NULL
	CONSTRAINT PK_PilotoClassif PRIMARY KEY CLUSTERED (pilotClassId)
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[DwTempoVolta](
	[corridaId] [int] NOT NULL,
	[pilotId] [int] NOT NULL,
	[volta] [varchar](50) NULL,
	[posicao] [varchar](50) NULL,
	[tempo] [varchar](50) NULL,
	[milesegundo] [varchar](50) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[DwPitStops](
	[corridaId] [int] NOT NULL,
	[pilotId] [int] NOT NULL,
	[parada] [varchar](50) NULL,
	[volta] [varchar](50) NULL,
	[tempo] [varchar](50) NULL,
	[duracao] [varchar](50) NULL,
	[milesegundo] [varchar](50) NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[DwQualif](
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

CREATE TABLE [dbo].[DwResult](
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

CREATE TABLE [dbo].[DimStatus](
	[statusId] [int] IDENTITY NOT NULL,
	[status] [varchar](50) NULL
	CONSTRAINT PK_Status PRIMARY KEY CLUSTERED (statusId)
) ON [PRIMARY]

GO

SELECT DISTINCT [pais]
INTO DwFormula1.DBO.DimPais FROM [BancoF2].[dbo].[Circuito]

SELECT DISTINCT [cidade]
INTO DwFormula1.DBO.DimCidade FROM [BancoF2].[dbo].[Circuito]

SELECT DISTINCT [nascionald]
INTO DwFormula1.DBO.DimNacional FROM [BancoF2].[dbo].[Piloto]

ALTER TABLE DWFormula1.DBO.DimPais ADD paisId int IDENTITY
ALTER TABLE DWFormula1.DBO.DimCidade ADD cidadeId int IDENTITY
ALTER TABLE DWFormula1.DBO.DimNacional ADD nacId int IDENTITY

--INSERÇÃO DOS DADOS
INSERT INTO [dbo].[DwCircuito](
	[circNome],
	[cidade],
	[pais],
	[lat],
	[lng])
SELECT [name]
      ,DP.paisId
      ,[country]
      ,[lat]
      ,[lng]
FROM [Teste].[dbo].[circuits3] OLD
INNER JOIN DWFormula1.DBO.DimPais DP ON OLD.[location] = DP.pais
INNER JOIN DWFormula1.DBO.DimCidade DC ON OLD.[country] = DC.cidadeId
GO

INSERT INTO [dbo].[DwCorrida](
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

INSERT INTO [dbo].[DwEquipeResult](
	[corridaId],
	[equipId],
	[pontos])
SELECT [raceId]
      ,[constructorId]
      ,[points]
FROM [Teste].[dbo].[constructorResults]
GO

INSERT INTO [dbo].[DwEquipe](
	[Nome],
	[pais])
SELECT [name]
      ,DN.nacId
FROM [Teste].[dbo].[constructors] OLD
INNER JOIN DWFormula1.DBO.DimNacional DN ON OLD.[nationality] = DN.[nascionald]
GO

INSERT INTO [dbo].[DwEquipeClassif](
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

INSERT INTO [dbo].[DwPiloto](
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
      ,DN.nacId
FROM [Teste].[dbo].[drivers] OLD
INNER JOIN DWFormula1.DBO.DimNacional DN ON OLD.[nationality] = DN.[nascionald]
GO

INSERT INTO [dbo].[DwPilotoClassif]([corridaId],
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

INSERT INTO [dbo].[DwTempoVolta](
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

INSERT INTO [dbo].[DwPitStops](
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

INSERT INTO [dbo].[DwQualif](
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

INSERT INTO [dbo].[DwResult](
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

INSERT INTO [dbo].[DimStatus](
	[status])
SELECT [status]
  FROM [Teste].[dbo].[status]
GO


--Ajustes
UPDATE dbo.DwCircuito SET pais = 'Bélgica' WHERE pais = 'Belgium'
UPDATE dbo.DwCircuito SET pais = 'Azerbaijão' WHERE pais = 'Azerbaijan'
UPDATE dbo.DwCircuito SET pais = 'Brasil' WHERE pais = 'Brazil'
UPDATE dbo.DwCircuito SET pais = 'Canadá' WHERE pais = 'Canada'
UPDATE dbo.DwCircuito SET pais = 'França' WHERE pais = 'France'
UPDATE dbo.DwCircuito SET pais = 'Alemanha' WHERE pais = 'Germany'
UPDATE dbo.DwCircuito SET pais = 'Hungria' WHERE pais = 'Hungary'
UPDATE dbo.DwCircuito SET pais = 'Índia' WHERE pais = 'India'
UPDATE dbo.DwCircuito SET pais = 'Itália' WHERE pais = 'Italy'
UPDATE dbo.DwCircuito SET pais = 'Japão' WHERE pais = 'Japan'
UPDATE dbo.DwCircuito SET pais = 'Coréia do Sul' WHERE pais = 'Korea'
UPDATE dbo.DwCircuito SET pais = 'Malásia' WHERE pais = 'Malaysia'
UPDATE dbo.DwCircuito SET pais = 'México' WHERE pais = 'Mexico'
UPDATE dbo.DwCircuito SET pais = 'Monâco' WHERE pais = 'Monaco'
UPDATE dbo.DwCircuito SET pais = 'Marrocos' WHERE pais = 'Marocco'
UPDATE dbo.DwCircuito SET pais = 'Holanda' WHERE pais = 'Netherlands'
UPDATE dbo.DwCircuito SET pais = 'Cingapura' WHERE pais = 'Singapore'
UPDATE dbo.DwCircuito SET pais = 'África do Sul' WHERE pais = 'South Africa'
UPDATE dbo.DwCircuito SET pais = 'Espanha' WHERE pais = 'Spain'
UPDATE dbo.DwCircuito SET pais = 'Suécia' WHERE pais = 'Sweden'
UPDATE dbo.DwCircuito SET pais = 'Suíça' WHERE pais = 'Switzerland'
UPDATE dbo.DwCircuito SET pais = 'Túrquia' WHERE pais = 'Turkey'
UPDATE dbo.DwCircuito SET pais = 'Inglaterra' WHERE pais = 'UK'
UPDATE dbo.DwCircuito SET pais = 'Estados Unidos' WHERE pais = 'USA'
UPDATE dbo.DwCircuito SET pais = 'Emirados Árabes' WHERE pais = 'UAE'
UPDATE dbo.DwCircuito SET pais = 'Rússia' WHERE pais = 'Russia'
UPDATE dbo.DwCircuito SET cidade = 'São Paulo' WHERE cidade = 'SÌ£o Paulo'
UPDATE dbo.DwCircuito SET cidade = 'Lisboa' WHERE cidade = 'Lisbon'
UPDATE dbo.DwCircuito SET cidade = 'Cidade do México' WHERE cidade = 'Mexico City'
UPDATE dbo.DwCircuito SET cidade = 'Berlim' WHERE cidade = 'Berlin'
UPDATE dbo.DwCircuito SET cidade = 'Montmeló' WHERE cidade = 'MontmelÌ_'
UPDATE dbo.DwCircuito SET cidade = 'Nürburg' WHERE cidade = 'NÌ_rburg'

UPDATE dbo.DwEquipe SET pais = 'Estados Unidos' WHERE pais LIKE 'American%'
UPDATE dbo.DwEquipe SET pais = 'Australia' WHERE pais LIKE 'Australian%'
UPDATE dbo.DwEquipe SET pais = 'Austria' WHERE pais LIKE 'Austrian%'
UPDATE dbo.DwEquipe SET pais = 'Bélgica' WHERE pais LIKE 'Belgium%'
UPDATE dbo.DwEquipe SET pais = 'Brasil' WHERE pais LIKE 'Brazilian%'
UPDATE dbo.DwEquipe SET pais = 'Inglaterra' WHERE pais LIKE 'British%'
UPDATE dbo.DwEquipe SET pais = 'Canadá' WHERE pais LIKE 'Canadian%'
UPDATE dbo.DwEquipe SET pais = 'Alemanha' WHERE pais LIKE 'German%' Or pais LIKE 'East%'
UPDATE dbo.DwEquipe SET pais = 'França' WHERE pais LIKE 'French%'
UPDATE dbo.DwEquipe SET pais = 'Holanda' WHERE pais LIKE 'Dutch%'
UPDATE dbo.DwEquipe SET pais = 'Estados Unidos' WHERE pais LIKE 'American%'
UPDATE dbo.DwEquipe SET pais = 'Hong Kong' WHERE pais LIKE 'Hong%'
UPDATE dbo.DwEquipe SET pais = 'Índia' WHERE pais LIKE 'Indian%'
UPDATE dbo.DwEquipe SET pais = 'Irlanda' WHERE pais LIKE 'Irish%'
UPDATE dbo.DwEquipe SET pais = 'Itália' WHERE pais LIKE 'Italian%'
UPDATE dbo.DwEquipe SET pais = 'Japão' WHERE pais LIKE 'Japanese%'
UPDATE dbo.DwEquipe SET pais = 'Málasia' WHERE pais LIKE 'Malaysian%'
UPDATE dbo.DwEquipe SET pais = 'México' WHERE pais LIKE 'Mexican%'
UPDATE dbo.DwEquipe SET pais = 'Nova Zelândia' WHERE pais LIKE 'New%'
UPDATE dbo.DwEquipe SET pais = 'Zimbuabue' WHERE pais LIKE 'Rhodesian%'
UPDATE dbo.DwEquipe SET pais = 'Rússia' WHERE pais LIKE 'Russian%'
UPDATE dbo.DwEquipe SET pais = 'África do Sul' WHERE pais LIKE 'South%'
UPDATE dbo.DwEquipe SET pais = 'Espanha' WHERE pais LIKE 'Spanish%'
UPDATE dbo.DwEquipe SET pais = 'Suiça' WHERE pais LIKE 'Swiss%'

UPDATE dbo.DwPiloto SET nascionald = 'Americano' WHERE nascionald LIKE 'American%'
UPDATE dbo.DwPiloto SET nascionald = 'Argentino' WHERE nascionald LIKE 'Argentine%'
UPDATE dbo.DwPiloto SET nascionald = 'Australiano' WHERE nascionald LIKE 'Australian%'
UPDATE dbo.DwPiloto SET nascionald = 'Austriaco' WHERE nascionald LIKE 'Austrian%'
UPDATE dbo.DwPiloto SET nascionald = 'Bélgico' WHERE nascionald LIKE 'Belgian%'
UPDATE dbo.DwPiloto SET nascionald = 'Brasileiro' WHERE nascionald LIKE 'Brazilian%'
UPDATE dbo.DwPiloto SET nascionald = 'Britânico' WHERE nascionald LIKE 'British%'
UPDATE dbo.DwPiloto SET nascionald = 'Canadense' WHERE nascionald LIKE 'Canadian%'
UPDATE dbo.DwPiloto SET nascionald = 'Chileno' WHERE nascionald LIKE 'Chilean%'
UPDATE dbo.DwPiloto SET nascionald = 'Tcheco' WHERE nascionald LIKE 'Czech%'
UPDATE dbo.DwPiloto SET nascionald = 'Dinamarquês' WHERE nascionald LIKE 'Danish%'
UPDATE dbo.DwPiloto SET nascionald = 'Holandês' WHERE nascionald LIKE 'Dutch%'
UPDATE dbo.DwPiloto SET nascionald = 'Alemão' WHERE nascionald LIKE 'East%' OR nascionald LIKE 'German%'
UPDATE dbo.DwPiloto SET nascionald = 'Finlandês' WHERE nascionald LIKE 'Finnish%'
UPDATE dbo.DwPiloto SET nascionald = 'Francês' WHERE nascionald LIKE 'French%'
UPDATE dbo.DwPiloto SET nascionald = 'Hungaro' WHERE nascionald LIKE 'Hunga%'
UPDATE dbo.DwPiloto SET nascionald = 'Indiano' WHERE nascionald LIKE 'Indian%'
UPDATE dbo.DwPiloto SET nascionald = 'Indonésio' WHERE nascionald LIKE 'Indonesian%'
UPDATE dbo.DwPiloto SET nascionald = 'Irlandês' WHERE nascionald LIKE 'Irish%'
UPDATE dbo.DwPiloto SET nascionald = 'Italiano' WHERE nascionald LIKE 'Italian%'
UPDATE dbo.DwPiloto SET nascionald = 'Japonês' WHERE nascionald LIKE 'Japanese%'
UPDATE dbo.DwPiloto SET nascionald = 'Liechtensteiniense' WHERE nascionald LIKE 'Liechte%'
UPDATE dbo.DwPiloto SET nascionald = 'Malásio' WHERE nascionald LIKE 'Malaysian%'
UPDATE dbo.DwPiloto SET nascionald = 'Mexicano' WHERE nascionald LIKE 'Mexican%'
UPDATE dbo.DwPiloto SET nascionald = 'Monegasca' WHERE nascionald LIKE 'Monegas%'

SELECT CR1.corridaId, C2.circId, PC1.pilotClassId, P1.pilotId, EQ.equipId, 
RES.resultId, EQCL.equipClassId, EQRE.equipResId, Q1.qualifId
INTO DWFormula1.DBO.DwFatos FROM DWFormula1.[dbo].[Resultado] RES
	INNER JOIN DWFormula1.[dbo].[Corrida] CR1 ON RES.corridaId = CR1.corridaId
	INNER JOIN DWFormula1.[dbo].[Piloto] P1 ON RES.pilotId = P1.pilotId
	INNER JOIN DWFormula1.[dbo].[Equipe] EQ ON RES.equipId = EQ.equipId
	INNER JOIN DWFormula1.[dbo].[Circuito] C2 ON CR1.circId = C2.circId
	INNER JOIN DWFormula1.[dbo].[PilotoClassif] PC1 ON P1.pilotId = PC1.pilotId AND CR1.corridaId = PC1.corridaId
	INNER JOIN DWFormula1.[dbo].[EquipeClassif] EQCL ON EQ.equipId = EQCL.equipId AND CR1.corridaId = EQCL.corridaId
	INNER JOIN DWFormula1.[dbo].[EquipeResult] EQRE ON EQ.equipId = EQRE.equipId AND CR1.corridaId = EQRE.corridaId
	INNER JOIN DWFormula1.[dbo].[Qualificacao] Q1 ON CR1.corridaId = Q1.corridaId

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
