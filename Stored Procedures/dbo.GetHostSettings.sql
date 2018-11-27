SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetHostSettings]
AS
BEGIN
	SELECT SettingName,
		   CASE WHEN Lower(SettingValue) Like N'fileid=%'
		        THEN dbo.[FilePath](SettingValue)
		        ELSE SettingValue 
		   END   AS SettingValue,
		   SettingIsSecure,
		   CreatedByUserID,
		   CreatedOnDate,
	       LastModifiedByUserID,
		   LastModifiedOnDate
	 FROM  dbo.[HostSettings];
END; -- Procedure
GO
