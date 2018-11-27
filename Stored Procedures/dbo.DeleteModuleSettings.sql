SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DeleteModuleSettings]
	@ModuleId int -- Not Null
AS
BEGIN
	DELETE 
	 FROM  dbo.[ModuleSettings]
	 WHERE ModuleId = @ModuleId
END; -- Procedure
GO
