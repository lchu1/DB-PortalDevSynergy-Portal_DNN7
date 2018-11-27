SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetTabModuleSettingsByName]
	@PortalId    Int,         -- Not Null
	@SettingName NVarChar(50) -- Not Null
AS
BEGIN
	SELECT S.TabModuleID, 
		   CASE WHEN Lower(S.SettingValue) LIKE N'fileid=%'
				THEN dbo.[FilePath](S.SettingValue)
				ELSE S.SettingValue 
		   END	AS SettingValue
	 FROM  dbo.[TabModuleSettings] S
	 JOIN  dbo.[TabModules]        M ON S.TabModuleID = M.TabModuleID
	 JOIN dbo.[Tabs]               T ON M.TabID       = T.TabID AND (T.PortalID = @PortalID OR T.PortalID IS NULL)
	 WHERE S.SettingName = @SettingName
END; -- Procedure
GO
