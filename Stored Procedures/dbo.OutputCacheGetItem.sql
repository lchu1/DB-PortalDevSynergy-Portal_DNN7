SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[OutputCacheGetItem]
	@CacheKey VarChar (36)
AS
BEGIN
    SELECT *
     FROM  dbo.OutputCache
     WHERE CacheKey = @CacheKey
END
GO
