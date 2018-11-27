SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_EntryPermissionMaintenance]
 @PortalId INT
AS
DECLARE @NotInPortalGroup INT
SET @NotInPortalGroup=1
BEGIN TRY
 DECLARE @sSQL nvarchar(500);
 DECLARE @ParmDefinition nvarchar(500);
 SELECT @sSQL = N'SELECT @retvalOUT = COUNT(p.PortalId) FROM dbo.Portals p WHERE p.PortalId=' + CAST(@PortalId AS NVARCHAR) + ' AND p.PortalGroupID=-1';
 SET @ParmDefinition = N'@retvalOUT int OUTPUT';
 EXEC sp_executesql @sSQL, @ParmDefinition, @retvalOUT=@NotInPortalGroup OUTPUT;
 SELECT @NotInPortalGroup;
END TRY
BEGIN CATCH
END CATCH
DELETE FROM dbo.DMX_EntryPermissions
WHERE 
 EXISTS(SELECT * FROM dbo.DMX_Entries e WHERE e.EntryId=dbo.DMX_EntryPermissions.EntryId AND e.PortalId=@PortalId)
 AND ((UserId>0 
   AND NOT EXISTS(SELECT * FROM dbo.Users u 
    INNER JOIN dbo.UserPortals up ON u.UserId=up.UserId
    WHERE u.UserId = dbo.DMX_EntryPermissions.UserId
     AND up.PortalId=@PortalId)
   AND @NotInPortalGroup=1)
  OR (UserId=-10 
   AND RoleId>0 
   AND NOT EXISTS(SELECT * FROM dbo.Roles r 
    WHERE r.RoleId = dbo.DMX_EntryPermissions.RoleId
     AND r.PortalId=@PortalId)))
GO
