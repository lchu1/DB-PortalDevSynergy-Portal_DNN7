SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_DeletePersonaBarPermission]
    @PermissionId           INT
AS
    DELETE FROM dbo.[PersonaBarPermission] 
        WHERE PermissionId = @PermissionId
GO
