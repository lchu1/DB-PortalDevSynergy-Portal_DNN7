SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[OutputCacheRemoveItem]
	@ItemId Int
AS
BEGIN
    DELETE
    FROM  dbo.OutputCache
    WHERE ItemId = @ItemId
END
GO
