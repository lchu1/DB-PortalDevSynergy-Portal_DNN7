SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_GetPersonaBarMenu]
AS
	SELECT 
        MenuId, 
        Identifier, 
        ModuleName, 
        FolderName,
        Controller, 
        ResourceKey, 
        Path, 
        Link, 
        CssClass, 
        IconFile,
        ParentId, 
        [Order], 
        AllowHost, 
        Enabled, 
        CreatedByUserId, 
        CreatedOnDate, 
        LastModifiedByUserId, 
        LastModifiedOnDate 
        
    FROM dbo.[PersonaBarMenu]
GO
