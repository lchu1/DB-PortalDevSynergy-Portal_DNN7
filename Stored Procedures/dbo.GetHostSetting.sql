SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetHostSetting]
    @SettingName nvarchar(50)
AS
BEGIN
    SELECT CASE WHEN Lower(SettingValue) Like N'fileid=%'
		        THEN dbo.[FilePath](SettingValue)
		        ELSE SettingValue 
		   END   AS SettingValue
     FROM  dbo.[HostSettings]
     WHERE SettingName = @SettingName;
END; -- Procedure
GO
