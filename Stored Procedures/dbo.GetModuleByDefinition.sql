SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetModuleByDefinition]
      @PortalId int,
      @DefinitionName nvarchar(128)
AS
IF(@PortalId IS NULL)
	SELECT M.*
	FROM dbo.vw_Modules M
	WHERE M.PortalId IS NULL
	  AND M.DefinitionName = @DefinitionName
	  AND M.IsDeleted = 0
	  AND M.IsTabDeleted = 0
ELSE
	SELECT M.*
	FROM dbo.vw_Modules M
	WHERE M.PortalId = @PortalId
	  AND M.DefinitionName = @DefinitionName
	  AND M.IsDeleted = 0
	  AND M.IsTabDeleted = 0
GO
