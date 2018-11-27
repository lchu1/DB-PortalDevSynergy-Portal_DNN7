SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetEntryPermissionsForUser]
 @PortalId INT,
 @EntryId INT,
 @UserId INT
AS
SELECT p.* FROM dbo.DMX_Permissions p 
 INNER JOIN dbo.DMX_EntryPermissions ep ON p.PermissionId=ep.PermissionId 
 LEFT JOIN dbo.vw_DMX_ActiveUserRoles ur ON ur.RoleId=ep.RoleId AND ur.UserId=@UserId
WHERE 
 (ep.RoleId=-1 OR NOT ur.UserId IS NULL OR ep.UserId=@UserId) 
 AND (ep.EntryId=@EntryId) 
 AND (ep.PortalId=@PortalId)
GO
