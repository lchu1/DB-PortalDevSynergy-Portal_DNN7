SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetModuleSetting]
    @ModuleId      Int,          -- not null!
    @SettingName   nVarChar(50)  -- not null or empty!
AS
BEGIN
	SELECT SettingName,
		   CASE WHEN Lower(SettingValue) LIKE N'fileid=%'
				THEN dbo.[FilePath](SettingValue)
				ELSE SettingValue  
		   END AS SettingValue
	 FROM  dbo.[ModuleSettings] 
	 WHERE ModuleID    = @ModuleId 
	   AND SettingName = @SettingName;
END; -- Procedure
GO
