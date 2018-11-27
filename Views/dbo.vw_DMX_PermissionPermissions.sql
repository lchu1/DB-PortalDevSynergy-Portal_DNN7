SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_DMX_PermissionPermissions]
AS
SELECT 
 pp.AllowAccess, 
 pp.Expires, 
 pp.PermissionId, 
 pp.PortalId, 
 pp.RoleId, 
 pp.UserId, 
 p.Addon, 
 p.PermissionKey, 
 p.ResourceFile, 
 ISNULL(u.Username, N'') AS Username, 
 ISNULL(u.DisplayName, N'') AS DisplayName, 
 ISNULL(r.RoleName, N'') AS RoleName
FROM dbo.DMX_PermissionPermissions pp
 INNER JOIN dbo.DMX_Permissions p ON pp.PermissionId = p.PermissionId 
 LEFT OUTER JOIN dbo.Users u ON pp.UserId = u.UserID
 LEFT OUTER JOIN dbo.Roles r ON pp.RoleId = r.RoleID
GO
