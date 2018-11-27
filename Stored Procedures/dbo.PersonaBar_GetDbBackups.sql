SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_GetDbBackups]
AS
	DECLARE @ProductEdition INT
	SET @ProductEdition = CAST(SERVERPROPERTY('EngineEdition') AS INT)

	IF (@ProductEdition = 5) --Check for SQL Azure
	BEGIN
		SELECT      
			'Unsupported' AS name, 
			NULL AS StartDate, 
			NULL AS FinishDate, 
			0 AS size, 
			NULL AS database_name, 
			'UNKNOWN' AS BackupType
	END
	ELSE
	BEGIN
		EXEC('SELECT TOP 20     
				name, 
				backup_start_date as StartDate, 
				backup_finish_date as FinishDate, 
				backup_size/1024 as size, 
				database_name, 
				CASE type
					WHEN ''D'' THEN ''Database''
					WHEN ''I'' THEN ''Differential database''
					WHEN ''L'' THEN ''Log''
					WHEN ''F'' THEN ''File or filegroup''
					WHEN ''G'' THEN ''Differential file''
					WHEN ''P'' THEN ''Partial''
					WHEN ''Q'' THEN ''Differential partial''
				END AS BackupType
				FROM         
				msdb..backupset
				WHERE
				database_name = DB_NAME() 
				ORDER BY backup_start_date DESC')
	END
GO
