SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DeleteTabModuleSettings]
	@TabModuleId Int
AS
BEGIN
	DELETE
	 FROM  dbo.[TabModuleSettings] 
	 WHERE TabModuleId = @TabModuleId;
END; -- Procedure
GO
