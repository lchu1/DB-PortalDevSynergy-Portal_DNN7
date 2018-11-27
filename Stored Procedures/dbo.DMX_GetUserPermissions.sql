SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetUserPermissions]
 @EntryId Int,
 @PortalId Int,
 @UserId Int
AS
SELECT DISTINCT p.PermissionKey
FROM dbo.DMX_EntryPermissions ep INNER JOIN dbo.DMX_Permissions p ON ep.PermissionId=p.PermissionId
LEFT JOIN dbo.vw_DMX_ActiveUserRoles ur ON ep.RoleId=ur.RoleID AND ur.UserId=@UserId
LEFT JOIN dbo.Users u ON u.UserId=@UserId
WHERE ep.EntryId=@EntryId
AND ep.PortalId=@PortalId
AND p.PortalId=@PortalId
AND (ep.RoleID=-1 OR NOT ur.UserId IS NULL OR ep.UserId=@UserId OR u.IsSuperUser=1)
GO
