SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DeleteModuleSetting]
	@ModuleId      int,          -- Not Null
	@SettingName   nVarChar(50)  -- Not Null or empty
AS
BEGIN
	DELETE
	 FROM  dbo.[ModuleSettings]
	 WHERE ModuleId    = @ModuleId
	   AND SettingName = @SettingName;
END; -- Procedure
GO
