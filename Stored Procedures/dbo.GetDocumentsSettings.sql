SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetDocumentsSettings]
	@ModuleId INT
AS
SELECT *
FROM DocumentsSettings
WHERE  ModuleId = @ModuleId
GO
