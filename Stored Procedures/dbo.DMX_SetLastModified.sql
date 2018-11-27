SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_SetLastModified]
 @PortalId Int,
 @EntryId Int = -1,
 @LastModified DATETIME = NULL
AS
IF @LastModified IS NULL
 BEGIN
  IF @EntryId=-1
   BEGIN
    UPDATE dbo.DMX_Entries
    SET LastModified=GETDATE()
    WHERE PortalId=@PortalId
    AND LastModified IS NULL;
   END
  ELSE
   BEGIN
    DECLARE @entrypath VARCHAR(4000)
    SET @entrypath = (SELECT [Path] 
      FROM dbo.DMX_Entries
      WHERE EntryId = @EntryId);
    UPDATE dbo.DMX_Entries
     SET LastModified=GETDATE()
     WHERE PortalId=@PortalId
    AND @entrypath LIKE [Path]+'%';
   END
 END
ELSE
 BEGIN
  UPDATE dbo.DMX_Entries
   SET LastModified=@LastModified
   WHERE PortalId=@PortalId
    AND EntryId=@EntryId;
 END
GO
