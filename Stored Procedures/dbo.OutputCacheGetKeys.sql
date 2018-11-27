SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[OutputCacheGetKeys]
	@ItemId Int
AS
BEGIN
    SELECT CacheKey
     FROM  dbo.OutputCache
     WHERE ItemId = @ItemId OR @ItemId IS NULL
END
GO
