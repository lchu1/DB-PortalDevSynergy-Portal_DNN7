SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[OutputCachePurgeCache]
AS
BEGIN
    DELETE
     FROM  dbo.OutputCache
END
GO
