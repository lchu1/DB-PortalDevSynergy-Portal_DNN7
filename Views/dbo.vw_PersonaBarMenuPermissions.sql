SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_PersonaBarMenuPermissions]
AS
SELECT  MP.MenuPermissionId,
        MP.MenuId,
        MP.PortalId,
        P.PermissionId,
        MP.RoleID,
        R.RoleName,
        MP.AllowAccess,
        MP.UserId,
        U.Username,
        U.DisplayName,
        P.PermissionKey,
        P.PermissionName,
        -- Add Columns to compact core system API
        -1 AS ModuleDefID,
        'PERSONABAR_MENU' AS PermissionCode,
        MP.CreatedByUserId,
        MP.CreatedOnDate,
        MP.LastModifiedByUserId,
        MP.LastModifiedOnDate
FROM dbo.[PersonaBarMenuPermission] AS MP
    INNER JOIN dbo.[PersonaBarPermission]       AS P  ON MP.PermissionID = P.PermissionID
    LEFT  JOIN dbo.[Roles]            AS R  ON MP.RoleID       = R.RoleID
    LEFT  JOIN dbo.[Users]            AS U  ON MP.UserID       = U.UserID
GO
