SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetPermissionsByPortal]
 @PortalId INT,
 @UserId INT = -1
AS
SELECT p.*, 
 CAST((SELECT COUNT(PermissionId) FROM dbo.DMX_PermissionPermissions pp 
   LEFT JOIN dbo.vw_DMX_ActiveUserRoles ur ON ur.RoleId=pp.RoleId AND ur.UserId=@UserId
   WHERE pp.PermissionId=p.PermissionId AND pp.AllowAccess=1
    AND (NOT ur.UserId IS NULL OR pp.RoleId=-1)) AS Bit) AS IsAllowedToEdit 
 FROM dbo.DMX_Permissions p 
 WHERE (p.PortalId=@PortalID)
GO
