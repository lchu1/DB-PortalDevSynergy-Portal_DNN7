SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetEntry]
 @EntryId INT,
 @Locale NVARCHAR(10)
AS
SELECT
 e.Author, e.CollectionId, e.Deleted, e.Entry, e.EntryId, e.EntryType, e.FileSize, e.Created, e.IsApproved,
 e.Keywords, e.LastModified, e.LastVersionId, e.LockedBy, e.LockedUntil, e.LockKey, e.MD5Hash, e.OriginalFileName,
 e.Owner, e.PortalId, e.State, e.Version, e.VersionsToKeep, e.WorkflowId, e.Path, e.PermissionsOnlyByAdmin,
 e.InheritAttributes, e.StorageProviderID, e.Thumbnail, e.Hidden,
 ISNULL(el.Title, e.Title) Title, ISNULL(el.Remarks, e.Remarks) Remarks
FROM
 dbo.DMX_Entries e
 LEFT JOIN dbo.DMX_EntriesML el ON e.EntryId=el.EntryId AND el.Locale=@Locale
WHERE
 e.[EntryId] = @EntryId
GO
