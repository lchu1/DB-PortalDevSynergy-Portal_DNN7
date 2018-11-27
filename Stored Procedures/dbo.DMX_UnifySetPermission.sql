SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UnifySetPermission]
 @PortalId INT,
 @UnifyingUserId INT,
 @CollectionId INT,
 @PermissionKey NVARCHAR(20),
 @RoleId INT,
 @UserId INT
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
 DECLARE @EntryType NVARCHAR(100)
 WHILE @Id IS NOT NULL
 BEGIN
  SELECT @EntryType = EntryType FROM dbo.DMX_Entries WHERE EntryId=@Id
  IF (SELECT COUNT(*) FROM dbo.DMX_PermissionEntrytypes WHERE PermissionId=@PermissionId AND @EntryType LIKE EntryType+'%') = 1
  BEGIN
   IF NOT EXISTS(SELECT * FROM dbo.DMX_EntryPermissions 
    WHERE [EntryId]=@Id AND [PermissionId]=@PermissionId AND [RoleId]=@RoleId AND [UserId]=@UserId AND [AllowAccess]=1 AND [PortalId]=@PortalId)
   INSERT INTO dbo.DMX_EntryPermissions ([EntryId], [PermissionId], [RoleId], [UserId], [AllowAccess], [Expires], [PortalId])
    VALUES (@Id, @PermissionId, @RoleId, @UserId, 1, NULL, @PortalId)
  END
  EXEC dbo.DMX_UnifySetPermission @PortalId, @UnifyingUserId, @Id, @PermissionKey, @RoleId, @UserId
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
