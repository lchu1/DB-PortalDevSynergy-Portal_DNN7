SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetTabModuleIdsBySettingNameAndValue]
	@PortalId INT,
	@SettingName NVARCHAR(50),
	@SettingValue NVARCHAR(max)
AS
BEGIN
	SELECT DISTINCT tms.TabModuleID
	FROM dbo.[TabModuleSettings] tms
			INNER JOIN dbo.[TabModules] tm ON tms.TabModuleID = tm.TabModuleID
			INNER JOIN dbo.[Tabs] t ON tm.TabID = t.TabID AND (t.PortalID = @PortalID OR t.PortalID IS NULL)
	WHERE tms.SettingName = @SettingName
	  AND tms.SettingValue = @SettingValue
END
GO
