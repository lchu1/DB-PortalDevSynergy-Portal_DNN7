SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_SavePersonaBarMenuPermission]
    @PortalId                   INT,
    @MenuId                     INT,
    @PermissionId               INT,
    @RoleId                     INT,
    @UserId                     INT,
    @AllowAccess                BIT,
    @CurrentUserId              INT
AS
BEGIN
    DECLARE @MenuPermissionId INT
    SELECT @MenuPermissionId = MenuPermissionId FROM dbo.[PersonaBarMenuPermission] 
        WHERE      (PortalId = @PortalId OR (PortalId IS NULL AND @PortalId IS NULL))
            AND    MenuId = @MenuId 
            AND    PermissionId = @PermissionId
            AND    (RoleId = @RoleId OR (RoleId IS NULL AND @RoleId IS NULL))
            AND    (UserId = @UserId OR (UserId IS NULL AND @UserId IS NULL))

    IF @MenuPermissionId > 0
    BEGIN
        UPDATE dbo.[PersonaBarMenuPermission]
            SET 
                AllowAccess = @AllowAccess,
                LastModifiedByUserId = CASE WHEN @CurrentUserId = -1 THEN NULL ELSE @CurrentUserId END,
                LastModifiedOnDate = GETDATE()
            WHERE MenuPermissionId = @MenuPermissionId

            SELECT @MenuPermissionId
    END
    ELSE
    BEGIN
        INSERT INTO dbo.[PersonaBarMenuPermission] (
            [PortalId],
            [MenuId],
            [PermissionId],
            [RoleId],
            [AllowAccess],
            [UserId],
            [CreatedByUserId],
            [CreatedOnDate],
            [LastModifiedByUserId],
            [LastModifiedOnDate]
        ) VALUES (
            @PortalId,
            @MenuId,
            @PermissionId,
            @RoleId,
            @AllowAccess,
            CASE WHEN @UserId = -1 THEN Null ELSE @UserId END,
            CASE WHEN @CurrentUserId = -1 THEN NULL ELSE @CurrentUserId END,
            GETDATE(),
            CASE WHEN @CurrentUserId = -1 THEN NULL ELSE @CurrentUserId END,
            GETDATE()
        )

        SELECT SCOPE_IDENTITY()
    END
END
GO
