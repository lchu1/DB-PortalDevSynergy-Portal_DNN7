SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetTabModuleSetting]
    @TabModuleId   Int,              -- not null!
    @SettingName   nVarChar(50)      -- not null or empty!
AS
BEGIN
	SELECT S.SettingName,
		   CASE WHEN S.SettingValue LIKE N'fileid=%'
				THEN dbo.[FilePath](S.SettingValue)
				ELSE S.SettingValue  
		   END AS SettingValue
	 FROM  dbo.[TabModuleSettings] S
	 WHERE TabModuleID = @TabModuleId 
	   AND SettingName = @SettingName;
END; -- Procedure
GO
