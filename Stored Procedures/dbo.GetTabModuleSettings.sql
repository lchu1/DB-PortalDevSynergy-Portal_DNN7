SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetTabModuleSettings]
    @TabModuleId Int -- Null: all tabmodules
AS
BEGIN
	SELECT SettingName,
		   CASE WHEN Lower(SettingValue) LIKE N'fileid=%'
				THEN dbo.[FilePath](SettingValue)
				ELSE SettingValue 
		   END  AS SettingValue
	 FROM  dbo.[TabModuleSettings] 
	 WHERE TabModuleID = @TabModuleId OR IsNull(@TabModuleId, -1) = -1
	 OPTION (OPTIMIZE FOR (@TabModuleId UNKNOWN))
END; -- Procedure
GO
