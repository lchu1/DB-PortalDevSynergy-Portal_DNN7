SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetModules]

	@PortalID int
	
AS
SELECT	* 
FROM dbo.vw_Modules
WHERE  PortalId = @PortalID
ORDER BY ModuleId
GO