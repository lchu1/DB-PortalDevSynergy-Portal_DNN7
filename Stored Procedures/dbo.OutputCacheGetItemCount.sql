SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[OutputCacheGetItemCount]
	@ItemId int
AS
BEGIN
    SELECT COUNT(*) N
     FROM  dbo.OutputCache
     WHERE ItemId = @ItemId
END
GO
