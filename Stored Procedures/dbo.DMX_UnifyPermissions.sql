SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UnifyPermissions]
 @PortalId Int,
 @EntryId Int,
 @UserId INT
AS
DECLARE @BasePath VARCHAR(2000)
SELECT @BasePath = (SELECT [Path] FROM dbo.DMX_Entries WHERE EntryId=@EntryId)
CREATE TABLE #ToChange 
 (EntryId INT, [Path] VARCHAR(2000), EntryType nvarchar(150));
INSERT INTO #ToChange
 (EntryId, [Path], EntryType)
SELECT DISTINCT e.EntryId, e.[Path], e.EntryType FROM dbo.DMX_Entries e INNER JOIN
 (SELECT ep.EntryId FROM dbo.DMX_EntryPermissions ep 
   INNER JOIN dbo.DMX_Permissions pt ON pt.PermissionId=ep.PermissionId
   LEFT JOIN dbo.vw_DMX_ActiveUserRoles r ON r.RoleId=ep.RoleId AND r.UserId=@UserId
   WHERE pt.PermissionKey='EDIT' AND (ep.UserId=@UserId OR NOT r.UserId IS NULL OR ep.RoleId=-1)) perm ON perm.EntryId=e.EntryId
 WHERE PortalId=@PortalId AND [Path] LIKE @BasePath+'_%';
CREATE TABLE #NewPerms (
 [AllowAccess] [bit] NULL,
 [EntryId] [int] NOT NULL,
 [Expires] [datetime] NULL,
 [PermissionId] [int] NOT NULL,
 [PortalId] [int] NOT NULL,
 [RoleId] [int] NOT NULL,
 [UserId] [int] NOT NULL,
 [EntryType] nvarchar(150))
INSERT INTO #NewPerms
 (AllowAccess, EntryId, Expires, PermissionId, PortalId, RoleId, UserId, EntryType)
SELECT ep.AllowAccess, ep.EntryId, ep.Expires, ep.PermissionId, ep.PortalId, ep.RoleId, ep.UserId, pet.EntryType
 FROM dbo.DMX_EntryPermissions ep
 INNER JOIN dbo.DMX_PermissionEntryTypes pet ON pet.PermissionId=ep.PermissionId
 WHERE ep.EntryId=@EntryId
DELETE FROM dbo.DMX_EntryPermissions
 WHERE EntryId IN (SELECT EntryId FROM #ToChange);
INSERT INTO dbo.DMX_EntryPermissions
 (AllowAccess, EntryId, Expires, PermissionId, PortalId, RoleId, UserId)
 SELECT ep.AllowAccess, tc.EntryId, ep.Expires, ep.PermissionId, ep.PortalId, ep.RoleId, ep.UserId
  FROM #NewPerms ep
  INNER JOIN #ToChange tc ON tc.EntryType LIKE ep.EntryType+'%';
DROP TABLE #NewPerms;
DROP TABLE #ToChange;
GO
