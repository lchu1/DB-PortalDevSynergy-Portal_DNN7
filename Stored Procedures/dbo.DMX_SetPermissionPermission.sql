SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_SetPermissionPermission]
 @PortalId INT, 
 @AllowAccess BIT, 
 @Expires DATETIME, 
 @PermissionId INT, 
 @RoleId INT, 
 @UserId INT
AS
IF NOT EXISTS
 (SELECT * FROM dbo.DMX_PermissionPermissions
  WHERE PortalId=@PortalId AND PermissionId=@PermissionId AND RoleId=@RoleId AND UserId=@UserId)
INSERT INTO dbo.DMX_PermissionPermissions (
 [PortalId],
 [AllowAccess],
 [Expires],
 [PermissionId],
 [RoleId],
 [UserId])
VALUES (
 @PortalId,
 @AllowAccess,
 @Expires,
 @PermissionId,
 @RoleId,
 @UserId)
ELSE
UPDATE dbo.DMX_PermissionPermissions SET
 [AllowAccess] = @AllowAccess,
 [Expires] = @Expires
WHERE
 [PermissionId] = @PermissionId
 AND [PortalId] = @PortalId
 AND [RoleId] = @RoleId
 AND [UserId] = @UserId
GO
