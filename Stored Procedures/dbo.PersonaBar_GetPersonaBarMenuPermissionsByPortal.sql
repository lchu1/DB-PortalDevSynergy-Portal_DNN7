SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_GetPersonaBarMenuPermissionsByPortal]
	@PortalID INT
AS
	SELECT 
        MenuPermissionId, 
        MenuId, 
        PortalId, 
        PermissionId, 
        RoleID, 
        RoleName, 
        AllowAccess, 
        UserId, 
        Username, 
        DisplayName, 
        PermissionKey, 
        PermissionName, 
        ModuleDefID,
        PermissionCode,
        CreatedByUserId, 
        CreatedOnDate, 
        LastModifiedByUserId, 
        LastModifiedOnDate 
    FROM dbo.[vw_PersonaBarMenuPermissions]
        WHERE PortalId = @PortalId OR PortalId IS NULL
GO
