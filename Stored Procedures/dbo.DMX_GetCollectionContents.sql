SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetCollectionContents]
 @PortalId INT,
 @CollectionId INT,
 @Locale VARCHAR(10)
AS
SELECT e.Author, e.CollectionId, e.Deleted, e.Entry, e.EntryId, e.EntryType, e.FileSize, e.Created, e.IsApproved,
 e.Keywords, e.LastModified, e.LastVersionId, e.LockedBy, e.LockedUntil, e.LockKey, e.MD5Hash, e.OriginalFileName,
 e.Owner, e.PortalId, e.State, e.Version, e.VersionsToKeep, e.WorkflowId, e.Path, e.PermissionsOnlyByAdmin,
 e.InheritAttributes, e.StorageProviderID, e.Thumbnail, e.Hidden,
 ISNULL(el.Title, e.Title) Title
 FROM dbo.DMX_Entries e
 LEFT JOIN dbo.DMX_EntriesML el ON e.EntryId=el.EntryId AND el.Locale=@Locale
 WHERE e.PortalId=@PortalId
 AND e.CollectionId=@CollectionId
 AND (e.Version=(SELECT MAX(Version) FROM dbo.DMX_Entries e2 WHERE e2.LastVersionId=e.LastVersionId AND e2.IsApproved=1))
 ORDER BY Title
GO
