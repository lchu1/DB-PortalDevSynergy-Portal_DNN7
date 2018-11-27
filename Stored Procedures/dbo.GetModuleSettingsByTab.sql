SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetModuleSettingsByTab]
    @TabId Int -- Not Null
AS
BEGIN
	SELECT S.ModuleID,
		   S.SettingName,
		   CASE WHEN Lower(S.SettingValue) LIKE N'fileid=%'
			    THEN dbo.[FilePath](S.SettingValue)
			    ELSE S.SettingValue 
		   END		 AS SettingValue
	 FROM  dbo.[ModuleSettings] S
	 JOIN  dbo.[TabModules]     M ON S.ModuleID = M.ModuleID
	 WHERE M.TabID = @TabId
	 ORDER BY S.ModuleID
END; -- Procedure
GO
