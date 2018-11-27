SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_ResetPermissions]
 @PortalId Int,
 @EntryId Int
AS
DECLARE @AdminRoleId INT
SELECT @AdminRoleId = (SELECT AdministratorRoleId FROM dbo.Portals WHERE PortalId=@PortalId);
DECLARE @BasePath VARCHAR(2000)
SELECT @BasePath = (SELECT [Path] FROM dbo.DMX_Entries WHERE EntryId=@EntryId);
DELETE dbo.DMX_EntryPermissions
 FROM dbo.DMX_EntryPermissions ep INNER JOIN dbo.DMX_Entries e ON e.EntryId=ep.EntryId
 WHERE e.PortalId=@PortalId AND e.[Path] LIKE @BasePath+'%';
INSERT INTO dbo.DMX_EntryPermissions
 (AllowAccess, EntryId, Expires, PermissionId, PortalId, RoleId, UserId)
 SELECT 1, e.EntryId, NULL, p.PermissionId, 0, @AdminRoleId, -10
 FROM dbo.DMX_Entries e, dbo.DMX_Permissions p
 WHERE 
  e.PortalId=@PortalId AND e.[Path] LIKE @BasePath+'%' AND (NOT e.EntryType LIKE 'Collection%')
  AND (p.PermissionKey = 'EDIT' OR p.PermissionKey = 'VIEW');
INSERT INTO dbo.DMX_EntryPermissions
 (AllowAccess, EntryId, Expires, PermissionId, PortalId, RoleId, UserId)
 SELECT 1, e.EntryId, NULL, p.PermissionId, 0, @AdminRoleId, -10
 FROM dbo.DMX_Entries e, dbo.DMX_Permissions p
 WHERE 
  e.PortalId=@PortalId AND e.[Path] LIKE @BasePath+'%' AND e.EntryType LIKE 'Collection%'
  AND (p.PermissionKey = 'EDIT' OR p.PermissionKey = 'VIEW'  OR p.PermissionKey = 'ADD');
GO
