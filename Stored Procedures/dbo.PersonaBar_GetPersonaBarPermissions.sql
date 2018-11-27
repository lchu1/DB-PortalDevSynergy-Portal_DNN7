SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_GetPersonaBarPermissions]
AS
	SELECT 
        [PermissionId],
	    [MenuId],
	    [PermissionKey],
	    [PermissionName],
	    [ViewOrder],
	    [CreatedByUserID],
	    [CreatedOnDate],
	    [LastModifiedByUserID],
	    [LastModifiedOnDate]
    FROM dbo.[PersonaBarPermission] ORDER BY ViewOrder ASC
GO
