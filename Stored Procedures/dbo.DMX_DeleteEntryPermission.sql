SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeleteEntryPermission]
 @EntryId INT,
 @PermissionId INT,
 @RoleId INT,
 @UserId INT
AS
DELETE FROM dbo.DMX_EntryPermissions
WHERE
 [EntryId] = @EntryId
 AND [PermissionId] = @PermissionId
 AND [RoleId] = @RoleId
 AND [UserId] = @UserId
GO
