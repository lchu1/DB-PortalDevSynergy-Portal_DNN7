SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetRoleSettings]
	@RoleId     int -- Not Null|-1
AS
BEGIN
	SELECT RoleSettingID,
		   RoleID,
		   SettingName,
		   CASE WHEN Lower(SettingValue) LIKE N'fileid=%'
			    THEN dbo.[FilePath](SettingValue)
			    ELSE SettingValue 
           END    AS SettingValue,
		   CreatedByUserID,
		   CreatedOnDate,
		   LastModifiedByUserID,
		   LastModifiedOnDate
	 FROM  dbo.[RoleSettings]
	 WHERE RoleID = @RoleId
END; -- Procedure
GO
