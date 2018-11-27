SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_EntryIsIn]
 @PortalId Int,
 @EntryId Int,
 @CollectionId INT
AS
DECLARE @entrypath VARCHAR(4000)
SET @entrypath = (SELECT [Path] 
 FROM dbo.DMX_Entries
 WHERE EntryId = @EntryId)
IF @entrypath LIKE '%;'+CAST(@CollectionId AS VARCHAR(10))+';%' OR @EntryId = @CollectionId
 SELECT 1
ELSE
 SELECT 0
GO
