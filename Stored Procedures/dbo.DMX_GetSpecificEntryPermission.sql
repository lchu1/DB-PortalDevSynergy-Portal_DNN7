SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetSpecificEntryPermission]
 @PortalId INT,
 @EntryId INT,
 @PermissionKey NVARCHAR(20),
 @UserId INT
AS
SELECT * FROM dbo.DMX_EntryPermissions ep
 INNER JOIN dbo.DMX_Permissions p ON ep.PermissionId=p.PermissionId
 LEFT JOIN dbo.vw_DMX_ActiveUserRoles ur ON ep.RoleId=ur.RoleId AND ur.UserId=@UserId
WHERE (ep.UserID=@UserId
 OR NOT ur.UserId IS NULL
 OR ep.RoleId=-1)
 AND ep.PortalId=@PortalId
 AND ep.EntryId=@EntryId
 AND p.PermissionKey=@PermissionKey
GO
