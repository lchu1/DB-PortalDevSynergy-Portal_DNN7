SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_GetPersonaBarExtensions]
AS
	SELECT 
        ExtensionId, 
        Identifier, 
        MenuId, 
        FolderName,
        Controller, 
        Container, 
        Path, 
        [Order], 
        Enabled, 
        CreatedByUserId, 
        CreatedOnDate, 
        LastModifiedByUserId, 
        LastModifiedOnDate 
    FROM dbo.[PersonaBarExtensions]
GO
