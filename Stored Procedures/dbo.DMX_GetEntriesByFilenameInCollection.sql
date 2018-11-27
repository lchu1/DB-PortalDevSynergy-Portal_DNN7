SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetEntriesByFilenameInCollection]
 @PortalId INT,
 @CollectionId INT,
 @Filename NVARCHAR(255)
AS
SELECT 
 e.*
FROM dbo.DMX_Entries e
WHERE (e.CollectionId=@CollectionId OR @CollectionId=-1)
AND e.OriginalFilename=@Filename
AND PortalId=@PortalId
AND e.LastVersionId=e.EntryId
GO
