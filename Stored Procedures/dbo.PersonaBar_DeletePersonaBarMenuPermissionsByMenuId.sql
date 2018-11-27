SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_DeletePersonaBarMenuPermissionsByMenuId]
    @PortalId INT,
	@MenuId INT
AS
DELETE FROM dbo.[PersonaBarMenuPermission]
WHERE
	[MenuId] = @MenuId AND (PortalId = @PortalId OR @PortalId IS NULL AND PortalId IS NULL)
GO
