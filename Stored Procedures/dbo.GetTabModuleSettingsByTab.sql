SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetTabModuleSettingsByTab]
    @TabId Int -- Not Null
AS
BEGIN
	SELECT S.TabModuleID,
		   S.SettingName,
		   CASE WHEN Lower(S.SettingValue) LIKE N'fileid=%'
				THEN dbo.[FilePath](S.SettingValue)
				ELSE S.SettingValue 
		   END	AS SettingValue
	 FROM  dbo.[TabModuleSettings] S
     JOIN  dbo.[TabModules]        M ON S.TabModuleID = M.TabModuleID
	 WHERE M.TabID = @TabId
	 ORDER BY S.TabModuleID
END; -- Procedure
GO
