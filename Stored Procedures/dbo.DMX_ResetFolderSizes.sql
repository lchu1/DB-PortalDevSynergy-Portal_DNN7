SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_ResetFolderSizes]
 @PortalId Int,
 @EntryId Int = -1
AS
BEGIN
 IF @EntryId > 0
 BEGIN
  DECLARE @entrypath VARCHAR(4000)
  SET @entrypath = (SELECT [Path] 
    FROM dbo.DMX_Entries
    WHERE EntryId = @EntryId);
  UPDATE dbo.DMX_Entries
  SET FileSize=NULL
  WHERE PortalId=@PortalId
  AND @entrypath LIKE [Path]+'%'
  AND EntryType LIKE 'Collection%';
 END
 IF @EntryId = -1
  UPDATE dbo.DMX_Entries
  SET FileSize=NULL
  WHERE PortalId=@PortalId
  AND EntryType LIKE 'Collection%';
 UPDATE dbo.DMX_Entries
 SET FileSize=
  (SELECT ISNULL(SUM(e1.FileSize), 0) FROM dbo.DMX_Entries e1 
  WHERE e1.EntryType LIKE 'File%'
  AND e1.[Path] LIKE e.Path+'%'
  AND e1.PortalId=e.PortalId
  AND e1.LastVersionId=e1.EntryId)
 FROM dbo.DMX_Entries e
 WHERE e.EntryType LIKE 'Collection%'
  AND e.FileSize IS NULL
  AND (e.PortalId=@PortalId OR @PortalId=-1);
END
GO
