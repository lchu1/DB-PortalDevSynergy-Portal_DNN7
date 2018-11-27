SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_DMX_Entries]
AS
SELECT 
 e.Author,
 e.CollectionId,
 e.Deleted,
 e.Entry, 
 e.EntryId,
 e.EntryType,
 e.FileSize,
 e.Created, 
 e.IsApproved,
 e.Keywords,
 e.LastModified,
 e.LastVersionId, 
 e.LockedBy,
 e.LockedUntil,
 e.LockKey,
 e.MD5Hash, 
 e.OriginalFileName,
 e.Owner,
 e.PortalId,
 e.State, 
 e.Version,
 e.VersionsToKeep,
 e.WorkflowId, 
 e.Path, 
 e.PermissionsOnlyByAdmin,
 e.InheritAttributes,
 e.StorageProviderID, 
 e.Remarks,
 e.Title,
 e.Thumbnail,
 e.Hidden, 
 ext.AccessRights,
 ext.Addon,
 ext.ControlToLoad, 
 ext.Custom,
 ext.DownloadUrl,
 ext.EntryTypes, 
 ext.Icon16,
 ext.Icon32,
 ext.IsPrivate,
 ext.MimeType, 
 ext.NodePattern,
 ext.ResourceFile,
 ext.SettingsControl, 
 ext.ViewByDefault,
 ext.EditControl,
 ext.ViewControl, 
 u.DisplayName AS OwnerDisplayName,
 CASE WHEN (PATINDEX('Collection%', EntryType) > 0) THEN 1 ELSE 0 END AS IsCollection, 
 CASE WHEN LockedUntil > GETDATE() THEN 1 ELSE 0 END AS IsLocked,
 ext.ExtensionKey
FROM dbo.DMX_Entries e
 INNER JOIN dbo.DMX_Extensions ext ON e.EntryType = ext.ExtensionKey AND e.PortalId = ext.PortalId
 LEFT OUTER JOIN dbo.Users u ON e.Owner = u.UserID
GO
