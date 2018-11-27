SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetEntryByFilename]
 @PortalId INT,
 @UserId INT,
 @CollectionId INT,
 @OriginalFileName NVARCHAR(255),
 @Locale VARCHAR(10)
AS
IF @UserId=-10
SELECT e.Author, e.CollectionId, e.Deleted, e.Entry, e.EntryId, e.EntryType, e.FileSize, e.Created, e.IsApproved,
 e.Keywords, e.LastModified, e.LastVersionId, e.LockedBy, e.LockedUntil, e.LockKey, e.MD5Hash, e.OriginalFileName,
 e.Owner, e.PortalId, e.State, e.Version, e.VersionsToKeep, e.WorkflowId, e.Path, e.PermissionsOnlyByAdmin,
 e.InheritAttributes, e.StorageProviderID, e.Thumbnail, e.Hidden,
 ISNULL(el.Title, e.Title) Title, ISNULL(el.Remarks, e.Remarks) Remarks
 FROM dbo.DMX_Entries e
 LEFT JOIN dbo.DMX_EntriesML el ON e.EntryId=el.EntryId AND el.Locale=@Locale
 WHERE e.PortalId=@PortalId
 AND e.OriginalFileName=@OriginalFileName
 AND (e.Version=(SELECT MAX(Version) FROM dbo.DMX_Entries e2 WHERE e2.LastVersionId=e.LastVersionId AND (e2.IsApproved=1 OR e2.Owner=@UserId)))
 AND (e.CollectionId=@CollectionId OR @CollectionId=-1)
ELSE
SELECT DISTINCT e.Author, e.CollectionId, e.Deleted, e.Entry, e.EntryId, e.EntryType, e.FileSize, e.Created, e.IsApproved,
 e.Keywords, e.LastModified, e.LastVersionId, e.LockedBy, e.LockedUntil, e.LockKey, e.MD5Hash, e.OriginalFileName,
 e.Owner, e.PortalId, e.State, e.Version, e.VersionsToKeep, e.WorkflowId, e.Path, e.PermissionsOnlyByAdmin,
 e.InheritAttributes, e.StorageProviderID, e.Thumbnail, e.Hidden,
 ISNULL(el.Title, e.Title) Title, ISNULL(el.Remarks, e.Remarks) Remarks
 FROM dbo.DMX_Entries e
 LEFT JOIN dbo.DMX_EntriesML el ON e.EntryId=el.EntryId AND el.Locale=@Locale
 INNER JOIN
  (SELECT ep.EntryId FROM dbo.DMX_EntryPermissions ep 
    INNER JOIN dbo.DMX_Permissions pt ON pt.PermissionId=ep.PermissionId AND pt.PermissionKey='VIEW' 
    LEFT JOIN dbo.vw_DMX_ActiveUserRoles r ON r.RoleId=ep.RoleId AND r.UserId=@UserId 
    WHERE (ep.UserId=@UserId OR NOT r.UserId IS NULL OR ep.RoleId=-1 OR (@UserId=-1 AND ep.RoleId=-3)))
  perm ON perm.EntryId=e.EntryId
 WHERE e.PortalId=@PortalId
 AND e.OriginalFileName=@OriginalFileName
 AND (e.Version=(SELECT MAX(Version) FROM dbo.DMX_Entries e2 WHERE e2.LastVersionId=e.LastVersionId AND (e2.IsApproved=1 OR e2.Owner=@UserId)))
 AND (e.CollectionId=@CollectionId OR @CollectionId=-1)
GO
