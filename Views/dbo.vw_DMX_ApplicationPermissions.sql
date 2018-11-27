SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_DMX_ApplicationPermissions]
AS
SELECT 
 ap.AllowAccess, 
 ap.Expires, 
 ap.PermissionId, 
 ap.PortalId, 
 ap.RoleId, 
 ap.UserId, 
 p.Addon, 
 p.PermissionKey, 
 p.ResourceFile, 
 ISNULL(u.Username, N'') AS Username, 
 ISNULL(u.DisplayName, N'') AS DisplayName, 
 ISNULL(r.RoleName, N'') AS RoleName
FROM dbo.DMX_ApplicationPermissions ap
 INNER JOIN dbo.DMX_Permissions p ON ap.PermissionId = p.PermissionId 
 LEFT OUTER JOIN dbo.Users u ON ap.UserId = u.UserID
 LEFT OUTER JOIN dbo.Roles r ON ap.RoleId = r.RoleID
GO
