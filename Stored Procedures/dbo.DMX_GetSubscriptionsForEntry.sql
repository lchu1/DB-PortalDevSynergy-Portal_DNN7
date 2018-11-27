SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetSubscriptionsForEntry]
 @EntryId INT
AS
BEGIN
 DECLARE @BasePath VARCHAR(2000)
 SELECT @BasePath = ';'+(SELECT [Path] FROM dbo.DMX_Entries WHERE EntryId=@EntryID);
 SELECT * FROM dbo.DMX_Subscriptions s
 WHERE @BasePath LIKE '%;'+CAST(s.EntryId AS VARCHAR(10))+';%'
 AND EXISTS (SELECT ep1.EntryId 
  FROM dbo.DMX_EntryPermissions ep1
  INNER JOIN dbo.DMX_Permissions Permission ON Permission.PermissionId=ep1.PermissionId 
  LEFT JOIN dbo.vw_DMX_ActiveUserRoles ur ON ur.RoleId=ep1.RoleId AND ur.UserID=s.UserId
  WHERE ep1.EntryId=@EntryId AND (NOT ur.UserId IS NULL OR ep1.UserId=s.UserId OR ep1.RoleId=-1)
   AND Permission.PermissionKey='VIEW')
END
GO
