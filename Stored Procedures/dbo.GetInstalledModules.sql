SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetInstalledModules]
AS
BEGIN
	SELECT		
		DM.DesktopModuleID, 
		DM.ModuleName,
		DM.FriendlyName,
		DM.Version,
		--Left Joined nulls will not add to the count
		COUNT(MDEF.DesktopModuleID) as Instances
	FROM dbo.[DesktopModules] AS DM
		--Paren's Will enforce inner join first before left outer joining
		LEFT JOIN (dbo.[ModuleDefinitions] MDEF 
				INNER JOIN dbo.[Modules] MODS ON MDEF.ModuleDefID = MODS.ModuleDefID)
	ON dm.DesktopModuleID = MDEF.DesktopModuleID 
	WHERE (IsAdmin = 0)
	GROUP BY DM.DesktopModuleID, DM.ModuleName, DM.FriendlyName, DM.Version
	ORDER BY DM.[FriendlyName] ASC
END
GO
