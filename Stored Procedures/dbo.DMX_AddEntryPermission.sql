SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddEntryPermission]
 @PortalId INT, 
 @AllowAccess BIT, 
 @EntryId INT, 
 @Expires DATETIME, 
 @PermissionId INT, 
 @RoleId INT, 
 @UserId INT
AS

IF NOT EXISTS(SELECT * FROM dbo.DMX_EntryPermissions WHERE PortalId=@PortalId AND EntryId=@EntryId AND PermissionId=@PermissionId AND RoleId=@RoleId AND UserId=@UserId)
INSERT INTO dbo.DMX_EntryPermissions (
 [PortalId],
 [AllowAccess],
 [EntryId],
 [Expires],
 [PermissionId],
 [RoleId],
 [UserId])
VALUES (
 @PortalId,
 @AllowAccess,
 @EntryId,
 @Expires,
 @PermissionId,
 @RoleId,
 @UserId)
GO
