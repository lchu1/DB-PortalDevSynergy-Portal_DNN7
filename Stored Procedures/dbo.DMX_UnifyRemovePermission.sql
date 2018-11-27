SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UnifyRemovePermission]
 @PortalId INT,
 @UnifyingUserId INT,
 @CollectionId INT,
 @PermissionKey NVARCHAR(20)
AS
BEGIN
 DECLARE @Id INT
 SELECT @Id = MIN(e.EntryId)
  FROM dbo.DMX_Entries e
  INNER JOIN
   (SELECT ep.EntryId FROM dbo.DMX_EntryPermissions ep INNER JOIN dbo.DMX_Permissions pt ON pt.PermissionId=ep.PermissionId
   LEFT JOIN dbo.UserRoles r ON r.RoleId=ep.RoleId WHERE pt.PermissionKey='EDIT' AND (ep.UserId=@UnifyingUserId OR r.UserId=@UnifyingUserId OR ep.RoleId=-1)) perm
  ON perm.EntryId=e.EntryId
  WHERE e.CollectionId=@CollectionId
 DECLARE @PermissionId INT
 SELECT @PermissionId = PermissionId FROM dbo.DMX_Permissions WHERE PermissionKey=@PermissionKey AND PortalId=@PortalId
 DECLARE @AdminRoleId INT
 SELECT @AdminRoleId=AdministratorRoleId FROM dbo.Portals WHERE PortalId=@PortalId
 WHILE @Id IS NOT NULL
 BEGIN
  DELETE FROM dbo.DMX_EntryPermissions
  FROM dbo.DMX_EntryPermissions ep
   WHERE ep.EntryId=@Id 
    AND ep.PermissionId=@PermissionId
    AND NOT (ep.RoleId=@AdminRoleId AND (@PermissionKey='VIEW' OR @PermissionKey='EDIT' OR @PermissionKey='ADD'))
    AND (@PermissionKey<>'EDIT' OR (SELECT COUNT(*) FROM dbo.UserRoles r WHERE r.UserId=@UnifyingUserId AND r.RoleId=ep.RoleId)=0)
    AND (@PermissionKey<>'EDIT' OR ep.UserId <> @UnifyingUserId)
  EXEC dbo.DMX_UnifyRemovePermission @PortalId, @UnifyingUserId, @Id, @PermissionKey
  SELECT @Id = MIN(e.EntryId)
   FROM dbo.DMX_Entries e
   INNER JOIN
    (SELECT ep.EntryId FROM dbo.DMX_EntryPermissions ep INNER JOIN dbo.DMX_Permissions pt ON pt.PermissionId=ep.PermissionId
    LEFT JOIN dbo.UserRoles r ON r.RoleId=ep.RoleId WHERE pt.PermissionKey='EDIT' AND (ep.UserId=@UnifyingUserId OR r.UserId=@UnifyingUserId OR ep.RoleId=-1)) perm 
   ON perm.EntryId=e.EntryId
   WHERE e.CollectionId=@CollectionId
   AND e.EntryId>@Id
 END
END
GO
