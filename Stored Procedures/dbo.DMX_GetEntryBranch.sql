SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetEntryBranch]
 @PortalId INT,
 @EntryId INT,
 @AllVersions BIT,
 @IncludeSelf BIT,
 @Locale NVARCHAR(6)
AS
EXEC dbo.DMX_UpdatePaths @PortalId, @EntryId;
DECLARE @Path VARCHAR(4000)
SELECT @Path=[Path] FROM dbo.DMX_Entries WHERE EntryId=@EntryID AND PortalId=@PortalID;
SELECT 
 e.Author, e.CollectionId, e.Deleted, e.Entry, e.EntryId, e.EntryType, e.FileSize, e.Created, e.IsApproved,
 e.Keywords, e.LastModified, e.LastVersionId, e.LockedBy, e.LockedUntil, e.LockKey, e.MD5Hash, e.OriginalFileName,
 e.Owner, e.PortalId, e.State, e.Version, e.VersionsToKeep, e.WorkflowId, e.Path, e.PermissionsOnlyByAdmin,
 e.InheritAttributes, e.StorageProviderID, e.Thumbnail, e.Hidden,
 ISNULL(el.Title, e.Title) Title, ISNULL(el.Remarks, e.Remarks) Remarks
FROM dbo.DMX_Entries e
 LEFT JOIN dbo.DMX_EntriesML el ON e.EntryId=el.EntryId AND el.Locale=@Locale
WHERE ((e.[Path] LIKE @Path+'%') OR (e.LastVersionId=@EntryId AND @AllVersions=1 AND @IncludeSelf=1))
 AND (@IncludeSelf=1 OR (NOT e.[Path]=@Path))
 AND (e.Version=(SELECT MAX(Version) FROM dbo.DMX_Entries e2 WHERE e2.LastVersionId=e.LastVersionId) OR @AllVersions=1)
GO
