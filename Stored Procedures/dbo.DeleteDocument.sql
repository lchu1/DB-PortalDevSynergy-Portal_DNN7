SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DeleteDocument]
	@ModuleId INT, 
	@ItemId INT
AS

DELETE FROM Documents
WHERE  ItemId = @ItemId
	AND ModuleId = @ModuleId
GO
