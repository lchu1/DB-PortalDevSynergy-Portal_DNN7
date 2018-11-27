SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DeleteTabModuleSetting]
	@TabModuleId   int,
	@SettingName   nVarChar(50)
AS
BEGIN
	DELETE
	 FROM  dbo.[TabModuleSettings]
	 WHERE TabModuleId = @TabModuleId
	   AND SettingName = @SettingName;
END; -- Procedure
GO
