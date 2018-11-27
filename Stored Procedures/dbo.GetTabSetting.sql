SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetTabSetting]
    @TabId         Int,         -- not null!
    @SettingName   nVarChar(50) -- not null or empty!
AS
BEGIN
	SELECT SettingName,
		   CASE WHEN SettingValue LIKE N'fileid=%'
				THEN dbo.[FilePath](SettingValue)
				ELSE SettingValue  
		   END AS SettingValue
	 FROM  dbo.[TabSettings] 
	 WHERE TabID = @TabId 
	   AND SettingName = @SettingName;
END; -- Procedure
GO
