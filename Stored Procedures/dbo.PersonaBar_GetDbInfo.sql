SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_GetDbInfo]
AS
	
	SELECT
		SERVERPROPERTY('ProductVersion') AS ProductVersion, 
		SERVERPROPERTY('ProductLevel') AS ServicePack, 
		SERVERPROPERTY('Edition') AS ProductEdition, 
		@@VERSION AS SoftwarePlatform
GO
