SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[OutputCacheAddItem]
	@ItemId     Int,
	@CacheKey   VarChar ( 36),
	@Data	    nVarChar(Max),
	@Expiration DateTime
AS
BEGIN
    INSERT INTO dbo.OutputCache
    (	ItemId, 
	CacheKey, 
	Data, 
	Expiration
    ) VALUES 
    (   @ItemId, 
	@CacheKey, 
	@Data, 
	@Expiration
    )
END
GO
