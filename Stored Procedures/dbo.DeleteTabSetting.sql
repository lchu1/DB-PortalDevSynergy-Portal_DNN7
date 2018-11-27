SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DeleteTabSetting]
	@TabID      	Int,         -- Not Null
	@SettingName	nVarChar(50) -- Not Null or empty
AS
BEGIN
	DELETE	
	 FROM  dbo.[TabSettings]
	 WHERE TabID       = @TabID
	   AND SettingName = @SettingName;
END; -- Procedure
GO
