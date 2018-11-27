SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetEntryListAsXml]
 @EntryList VARCHAR(300),
 @UserId INT
AS
DECLARE @Ents TABLE (s NVARCHAR(512))
INSERT INTO @Ents (s) SELECT s FROM dbo.DMX_Split(@EntryList,';')
SELECT
 1 AS Tag,
 NULL AS Parent,
 e.EntryId AS [Entry!1!EntryId!ID], 
 e.Author AS [Entry!1!Author],
 e.CollectionId AS [Entry!1!CollectionId],
 e.Created AS [Entry!1!Created],
 e.Deleted AS [Entry!1!Deleted],
 e.Entry AS [Entry!1!Entry],
 e.EntryType AS [Entry!1!EntryType],
 e.FileSize AS [Entry!1!FileSize],
 e.IsApproved AS [Entry!1!IsApproved],
 e.Keywords AS [Entry!1!Keywords],
 e.LastVersionId AS [Entry!1!LastVersionId],
 e.LockedBy AS [Entry!1!LockedBy],
 e.OriginalFileName AS [Entry!1!OriginalFileName],
 e.PortalId AS [Entry!1!PortalId],
 e.Owner AS [Entry!1!Owner],
 e.Version AS [Entry!1!Version],
 e.LastModified AS [Entry!1!LastModified],
 e.LockedUntil AS [Entry!1!LockedUntil],
 e.LockKey AS [Entry!1!LockKey],
 e.MD5Hash AS [Entry!1!MD5Hash],
 e.State AS [Entry!1!State],
 e.VersionsToKeep AS [Entry!1!VersionsToKeep],
 e.WorkflowId AS [Entry!1!WorkflowId],
 ext.EditControl AS [Entry!1!EditControl],
 ext.ViewControl AS [Entry!1!ViewControl],
 REPLACE(dbo.DMX_fn_URLEncode(dbo.DMX_fn_GetPath(e.EntryId, e.PortalId, '')), '''', '\''') AS [Entry!1!FullPath],
 CAST (CASE WHEN e.LockedUntil > GETDATE() THEN 1 ELSE 0 END AS BIT) AS [Entry!1!IsLocked],
 CAST (CASE WHEN subs.EntryID IS NULL THEN 0 ELSE 1 END AS BIT) AS [Entry!1!Subscription],
 NULL AS [Permission!2!PermissionKey]
FROM
 @Ents ents
 INNER JOIN dbo.DMX_Entries e ON ents.s=e.EntryId
 INNER JOIN dbo.DMX_Extensions ext ON ext.ExtensionKey=e.EntryType AND e.PortalId=ext.PortalId
 LEFT JOIN (SELECT * FROM dbo.DMX_Subscriptions WHERE UserID=@UserId) subs ON subs.EntryId=e.EntryId
UNION ALL
SELECT DISTINCT
 2,
 1,
 e.EntryId, 
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 p.PermissionKey AS [Permission!2!PermissionKey]
FROM
 @Ents ents
 INNER JOIN dbo.DMX_Entries e ON ents.s=e.EntryId
 INNER JOIN dbo.DMX_EntryPermissions ep ON ep.EntryId=e.EntryId
 INNER JOIN dbo.DMX_Permissions p ON p.PermissionId=ep.PermissionId
 LEFT JOIN dbo.vw_DMX_ActiveUserRoles r ON r.RoleId=ep.RoleId AND r.UserId=@UserId
WHERE
 (ep.UserId=@UserId OR NOT r.UserId IS NULL OR ep.RoleId=-1)
FOR XML EXPLICIT
GO
