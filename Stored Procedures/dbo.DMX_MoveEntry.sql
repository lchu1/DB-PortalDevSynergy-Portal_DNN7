SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_MoveEntry]
 @PortalId Int,
 @EntryId Int,
 @NewCollectionId INT
AS
DECLARE @destpath VARCHAR(4000)
IF @NewCollectionId=0
 SET @destpath = '0;'
ELSE
 SET @destpath = (SELECT [Path] 
  FROM dbo.DMX_Entries
  WHERE EntryId = @NewCollectionId);
IF NOT @destpath LIKE '%;'+CAST(@EntryId AS VARCHAR(10))+';%' AND @EntryId <> @NewCollectionId
UPDATE dbo.DMX_Entries
 SET CollectionId=@NewCollectionId
WHERE
 LastVersionId=@EntryId
 AND PortalId=@PortalId
GO
