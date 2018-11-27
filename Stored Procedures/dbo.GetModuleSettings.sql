SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetModuleSettings]
    @ModuleId Int -- Null: settings from all modules
AS
BEGIN
	SELECT SettingName,
		   CASE WHEN Lower(SettingValue) LIKE N'fileid=%'
			    THEN dbo.[FilePath](SettingValue)
				ELSE SettingValue 
		   END       AS SettingValue
	 FROM  dbo.[ModuleSettings] 
	 WHERE ModuleID = @ModuleId OR IsNull(@ModuleId, -1) = -1
	 OPTION (OPTIMIZE FOR (@ModuleId UNKNOWN))
END; -- Procedure
GO
