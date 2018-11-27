SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_DeletePersonaBarMenuPermissionById]
	@MenuPermissionId INT
AS
DELETE FROM dbo.[PersonaBarMenuPermission]
WHERE
	[MenuPermissionId] = @MenuPermissionId
GO
