SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddFolder]
 @PortalId INT,
 @CollectionId INT=0,
 @FolderName NVARCHAR(1000)='New Folder',
 @ViewRoles VARCHAR(2000)='',
 @EditRoles VARCHAR(2000)='',
 @AddRoles VARCHAR(2000)='',
 @ApproveRoles VARCHAR(2000)=''
AS
BEGIN
 DECLARE @Owner INT
 SET @Owner = (SELECT AdministratorId FROM dbo.Portals WHERE PortalId=@PortalId)
 DECLARE @NewId INT
 INSERT INTO dbo.DMX_Entries
  (CollectionId, Created, Deleted, Entry, EntryType, IsApproved, Owner, PortalId, Version, PermissionsOnlyByAdmin, Title, InheritAttributes)
  VALUES
  (@CollectionId, GETDATE(), 0, '', 'Collection', 1, @Owner, @PortalId, 1, 0, @FolderName, 1);
 SET @NewId = SCOPE_IDENTITY();
 INSERT INTO dbo.DMX_Log
  ([Action],[Datime],[EntryId],[UserId])
 VALUES ('Add', GETDATE(), @NewId, @Owner);
 DECLARE @AdminRoleId INT
 SET @AdminRoleId = (SELECT AdministratorRoleId FROM dbo.Portals WHERE PortalId=@PortalId)
 IF @ViewRoles='' AND @EditRoles='' AND @AddRoles='' AND @ApproveRoles=''
  BEGIN
   IF @CollectionId=0
    BEGIN
     -- set Admin roles for default folder under root
     INSERT INTO dbo.DMX_EntryPermissions
      ([AllowAccess],[EntryId],[PermissionId],[PortalId],[RoleId],[UserId])
     SELECT 1, @NewId, PermissionId, @PortalId, @AdminRoleId, -10
      FROM dbo.DMX_Permissions
      WHERE PortalId=@PortalId AND (PermissionKey='VIEW' OR PermissionKey='EDIT' OR PermissionKey='ADD');
    END
   ELSE
    -- Inherit permissions from parent
    INSERT INTO dbo.DMX_EntryPermissions
     ([AllowAccess],[EntryId],[PermissionId],[PortalId],[RoleId],[UserId])
    SELECT 1, @NewId, [PermissionId],[PortalId],[RoleId],[UserId]
     FROM dbo.DMX_EntryPermissions
     WHERE EntryId=@CollectionId;
  END
 ELSE
  BEGIN
   -- set View roles
   INSERT INTO dbo.DMX_EntryPermissions
    ([AllowAccess],[EntryId],[PermissionId],[PortalId],[RoleId],[UserId])
   SELECT DISTINCT 1, @NewId, p1.PermissionId, @PortalId, r1.RoleId, -10
    FROM dbo.DMX_Split(@ViewRoles, ';') spl1
     INNER JOIN dbo.Roles r1 ON (CAST(r1.RoleId AS VARCHAR(10))=spl1.s OR r1.Rolename=spl1.s)
     INNER JOIN dbo.DMX_Permissions p1 ON (p1.PortalId=@PortalId AND p1.PermissionKey='VIEW')
    WHERE NOT @ViewRoles=''
      AND NOT EXISTS (SELECT 'X' FROM dbo.DMX_EntryPermissions
        WHERE [AllowAccess]=1 AND [EntryId]= @NewId AND [PermissionId]=p1.PermissionId AND [PortalId]= @PortalId AND [RoleId]=r1.RoleId AND [UserId]=-10);
   -- set Edit roles
   INSERT INTO dbo.DMX_EntryPermissions
    ([AllowAccess],[EntryId],[PermissionId],[PortalId],[RoleId],[UserId])
   SELECT DISTINCT 1, @NewId, p1.PermissionId, @PortalId, r1.RoleId, -10
    FROM dbo.DMX_Split(@EditRoles, ';') spl1
     INNER JOIN dbo.Roles r1 ON (CAST(r1.RoleId AS VARCHAR(10))=spl1.s OR r1.Rolename=spl1.s)
     INNER JOIN dbo.DMX_Permissions p1 ON (p1.PortalId=@PortalId AND p1.PermissionKey='EDIT')
    WHERE NOT @EditRoles=''
      AND NOT EXISTS (SELECT 'X' FROM dbo.DMX_EntryPermissions
        WHERE [AllowAccess]=1 AND [EntryId]= @NewId AND [PermissionId]=p1.PermissionId AND [PortalId]= @PortalId AND [RoleId]=r1.RoleId AND [UserId]=-10);
   -- set Add roles
   INSERT INTO dbo.DMX_EntryPermissions
    ([AllowAccess],[EntryId],[PermissionId],[PortalId],[RoleId],[UserId])
   SELECT DISTINCT 1, @NewId, p1.PermissionId, @PortalId, r1.RoleId, -10
    FROM dbo.DMX_Split(@AddRoles, ';') spl1
     INNER JOIN dbo.Roles r1 ON (CAST(r1.RoleId AS VARCHAR(10))=spl1.s OR r1.Rolename=spl1.s)
     INNER JOIN dbo.DMX_Permissions p1 ON (p1.PortalId=@PortalId AND p1.PermissionKey='ADD')
    WHERE NOT @AddRoles=''
      AND NOT EXISTS (SELECT 'X' FROM dbo.DMX_EntryPermissions
        WHERE [AllowAccess]=1 AND [EntryId]= @NewId AND [PermissionId]=p1.PermissionId AND [PortalId]= @PortalId AND [RoleId]=r1.RoleId AND [UserId]=-10);
   -- set Approve roles
   INSERT INTO dbo.DMX_EntryPermissions
    ([AllowAccess],[EntryId],[PermissionId],[PortalId],[RoleId],[UserId])
   SELECT DISTINCT 1, @NewId, p1.PermissionId, @PortalId, r1.RoleId, -10
    FROM dbo.DMX_Split(@ApproveRoles, ';') spl1
     INNER JOIN dbo.Roles r1 ON (CAST(r1.RoleId AS VARCHAR(10))=spl1.s OR r1.Rolename=spl1.s)
     INNER JOIN dbo.DMX_Permissions p1 ON (p1.PortalId=@PortalId AND p1.PermissionKey='APPROVE')
    WHERE NOT @ApproveRoles=''
      AND NOT EXISTS (SELECT 'X' FROM dbo.DMX_EntryPermissions
        WHERE [AllowAccess]=1 AND [EntryId]= @NewId AND [PermissionId]=p1.PermissionId AND [PortalId]= @PortalId AND [RoleId]=r1.RoleId AND [UserId]=-10);
   -- make sure Admin is part of this
   INSERT INTO dbo.DMX_EntryPermissions
    ([AllowAccess],[EntryId],[PermissionId],[PortalId],[RoleId],[UserId])
   SELECT DISTINCT 1, @NewId, p.PermissionId, @PortalId, @AdminRoleId, -10
    FROM dbo.DMX_Permissions p
    WHERE p.PortalId=@PortalId AND (p.PermissionKey='VIEW' OR p.PermissionKey='EDIT' OR p.PermissionKey='ADD')
    AND NOT EXISTS(SELECT * FROM dbo.DMX_EntryPermissions ep 
        WHERE ep.PermissionId=p.PermissionId AND ep.EntryId=@NewId AND ep.RoleId=@AdminRoleId);
  END
END
GO
