SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_SavePersonaBarMenuDefaultPermissions]
    @MenuId                     INT,
    @RoleNames                  NVARCHAR(1024)
AS
BEGIN
    IF EXISTS(SELECT MenuId FROM dbo.[PersonaBarMenuDefaultPermissions] WHERE MenuId = @MenuId)
    BEGIN
        UPDATE dbo.[PersonaBarMenuDefaultPermissions]
            SET 
                RoleNames = @RoleNames
            WHERE MenuId = @MenuId

            SELECT Id FROM dbo.[PersonaBarMenuDefaultPermissions] WHERE MenuId = @MenuId
    END
    ELSE
    BEGIN
        INSERT INTO dbo.[PersonaBarMenuDefaultPermissions] (
            [MenuId],
            [RoleNames]
        ) VALUES (
            @MenuId,
            @RoleNames
        )

        SELECT SCOPE_IDENTITY()
    END
END
GO
