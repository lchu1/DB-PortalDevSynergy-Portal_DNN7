SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetModuleUsageList]
AS
SELECT 
 dm.FolderName,
 dm.ModuleName,
 dm.FriendlyName,
 (SELECT COUNT(*) FROM dbo.Modules m
   INNER JOIN dbo.ModuleDefinitions md ON m.ModuleDefID=md.ModuleDefID
   WHERE md.DesktopModuleID=dm.DesktopModuleID) AS NrInstances
FROM dbo.DesktopModules dm
 ORDER BY dm.FolderName
GO
