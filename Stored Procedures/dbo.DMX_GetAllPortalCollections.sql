SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetAllPortalCollections]
 @PortalId INT,
 @UserId INT,
 @Locale VARCHAR(10)
AS
IF @UserId=-10
 SELECT e.Author, e.CollectionId, e.Deleted, e.Entry, e.EntryId, e.EntryType, e.FileSize, e.Created, e.IsApproved,
  e.Keywords, e.LastModified, e.LastVersionId, e.LockedBy, e.LockedUntil, e.LockKey, e.MD5Hash, e.OriginalFileName,
  e.Owner, e.PortalId, e.State, e.Version, e.VersionsToKeep, e.WorkflowId, e.Path, e.PermissionsOnlyByAdmin,
  e.InheritAttributes, e.StorageProviderID, e.Thumbnail, e.Hidden,
  ISNULL(el.Title, e.Title) Title
  FROM dbo.DMX_Entries e
  LEFT JOIN dbo.DMX_EntriesML el ON e.EntryId=el.EntryId AND el.Locale=@Locale
  WHERE e.PortalId=@PortalId
  AND e.EntryType LIKE 'Collection%'
  ORDER BY Title
ELSE
 SELECT DISTINCT e.Author, e.CollectionId, e.Deleted, e.Entry, e.EntryId, e.EntryType, e.FileSize, e.Created, e.IsApproved,
  e.Keywords, e.LastModified, e.LastVersionId, e.LockedBy, e.LockedUntil, e.LockKey, e.MD5Hash, e.OriginalFileName,
  e.Owner, e.PortalId, e.State, e.Version, e.VersionsToKeep, e.WorkflowId, e.Path, e.PermissionsOnlyByAdmin,
  e.InheritAttributes, e.StorageProviderID, e.Thumbnail, e.Hidden,
  ISNULL(el.Title, e.Title) Title
  FROM dbo.DMX_Entries e
  LEFT JOIN dbo.DMX_EntriesML el ON e.EntryId=el.EntryId AND el.Locale=@Locale
  INNER JOIN
   (SELECT ep.EntryId FROM dbo.DMX_EntryPermissions ep 
     INNER JOIN dbo.DMX_Permissions pt ON pt.PermissionId=ep.PermissionId AND pt.PermissionKey='VIEW' 
     LEFT JOIN dbo.vw_DMX_ActiveUserRoles r ON r.RoleId=ep.RoleId AND r.UserId=@UserId 
     WHERE (ep.UserId=@UserId OR NOT r.UserId IS NULL OR ep.RoleId=-1 OR (@UserId=-1 AND ep.RoleId=-3)))
   perm ON perm.EntryId=e.EntryId
  WHERE e.PortalId=@PortalId
  AND e.EntryType LIKE 'Collection%'
  ORDER BY Title
GO
