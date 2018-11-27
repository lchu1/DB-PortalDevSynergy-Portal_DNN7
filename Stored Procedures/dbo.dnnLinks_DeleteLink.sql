SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[dnnLinks_DeleteLink]

	@ItemId INT,
	@ModuleId INT

AS

DELETE
FROM dbo.Links
WHERE  ItemID = @ItemId AND ModuleID = @ModuleId
GO
