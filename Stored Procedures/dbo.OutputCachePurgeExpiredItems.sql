SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[OutputCachePurgeExpiredItems]
	@CurrentUtcDateTime DateTime
AS
BEGIN
    DELETE
     FROM  dbo.OutputCache
     WHERE Expiration <= @CurrentUtcDateTime
END
GO
