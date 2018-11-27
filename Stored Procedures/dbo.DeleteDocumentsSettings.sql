SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE  PROCEDURE [dbo].[DeleteDocumentsSettings]
	@ModuleId INT
AS
DELETE
FROM DocumentsSettings
WHERE  ModuleId = @ModuleId
GO
