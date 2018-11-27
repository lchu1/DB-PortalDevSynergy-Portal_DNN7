SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_SavePersonaBarPermission]
	@MenuId		        INT,
	@PermissionKey		VARCHAR(50),
	@PermissionName		VARCHAR(50),
	@CurrentUserId	    INT
AS
    IF EXISTS(SELECT PermissionId FROM dbo.[PersonaBarPermission]
                WHERE ((@MenuId IS NULL AND MenuId IS NULL) OR MenuId = @MenuId) AND PermissionKey = @PermissionKey)
    BEGIN
        UPDATE dbo.[PersonaBarPermission]  SET
	        [MenuId] = @MenuId,
	        [PermissionName] = @PermissionName,
	        [LastModifiedByUserID] = @CurrentUserId,
	        [LastModifiedOnDate] = GETDATE()
        WHERE ((@MenuId IS NULL AND MenuId IS NULL) OR MenuId = @MenuId) AND PermissionKey = @PermissionKey

        SELECT PermissionId FROM dbo.[PersonaBarPermission]
                WHERE ((@MenuId IS NULL AND MenuId IS NULL) OR MenuId = @MenuId) AND PermissionKey = @PermissionKey
    END
    ELSE
    BEGIN
        INSERT INTO dbo.[PersonaBarPermission] (
	        [MenuId],
	        [PermissionKey],
	        [PermissionName],
	        [CreatedByUserID],
	        [CreatedOnDate],
	        [LastModifiedByUserID],
	        [LastModifiedOnDate]
        ) VALUES (
	        @MenuId,
	        @PermissionKey,
	        @PermissionName,
	        @CurrentUserId,
	        GETDATE(),
	        @CurrentUserId,
	        GETDATE()
        )

        SELECT SCOPE_IDENTITY()
    END
GO
