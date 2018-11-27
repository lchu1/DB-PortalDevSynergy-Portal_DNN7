SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_DMX_EntryPermissions]
AS
SELECT
 ep.AllowAccess,
 ep.EntryId,
 ep.Expires, 
 ep.PermissionId,
 ep.PortalId,
 ep.RoleId, 
 ep.UserId,
 p.Addon,
 p.PermissionKey, 
 p.ResourceFile,
 ISNULL(u.Username, N'') AS Username,
 ISNULL(u.DisplayName, N'') AS DisplayName,
 ISNULL(r.RoleName, N'') AS RoleName
FROM dbo.DMX_EntryPermissions ep
 INNER JOIN dbo.DMX_Permissions p ON ep.PermissionId = p.PermissionId
 LEFT OUTER JOIN dbo.Roles r ON ep.RoleId = r.RoleID
 LEFT OUTER JOIN dbo.Users u ON ep.UserId = u.UserID
GO
