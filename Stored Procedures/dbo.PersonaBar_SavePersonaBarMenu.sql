SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_SavePersonaBarMenu]
    @Identifier                 NVARCHAR(50),
    @ModuleName                 NVARCHAR(50),
    @FolderName               NVARCHAR(50),
    @Controller                 NVARCHAR(260),
    @ResourceKey                NVARCHAR(50),
    @Path                       NVARCHAR(260),
    @Link                       NVARCHAR(260),
    @CssClass                   NVARCHAR(50),
    @ParentId                   INT,
    @Order                      INT,
    @AllowHost                  BIT,
    @Enabled                    BIT,
    @CurrentUserId              INT,
    @IconFile                   NVARCHAR(260) = ''
AS
BEGIN
    IF EXISTS(SELECT Identifier FROM dbo.[PersonaBarMenu] WHERE Identifier = @Identifier)
    BEGIN
        UPDATE dbo.[PersonaBarMenu]
            SET 
                ModuleName = @ModuleName,
                FolderName = @FolderName,
                ResourceKey = @ResourceKey,
                Path = @Path,
                Link = @Link,
                CssClass = @CssClass,
                IconFile = @IconFile,
                ParentId = @ParentId,
                [Order] = @Order,
                AllowHost = @AllowHost,
                Enabled = @Enabled,
                LastModifiedByUserId = CASE WHEN @CurrentUserId = -1 THEN NULL ELSE @CurrentUserId END,
                LastModifiedOnDate = GETDATE()
            WHERE Identifier = @Identifier

            SELECT MenuId FROM dbo.[PersonaBarMenu] WHERE Identifier = @Identifier
    END
    ELSE
    BEGIN
        INSERT INTO dbo.[PersonaBarMenu] (
            [Identifier],
            [ModuleName],
            [FolderName],
            [Controller],
            [ResourceKey],
            [Path],
            [Link],
            [CssClass],
            [IconFile],
            [ParentId],
            [Order],
            [AllowHost],
            [Enabled],
            [CreatedByUserId],
            [CreatedOnDate],
            [LastModifiedByUserId],
            [LastModifiedOnDate]
        ) VALUES (
            @Identifier,
            @ModuleName,
            @FolderName,
            @Controller,
            @ResourceKey,
            @Path,
            @Link,
            @CssClass,
            @IconFile,
            @ParentId,
            @Order,
            @AllowHost,
            @Enabled,
            CASE WHEN @CurrentUserId = -1 THEN NULL ELSE @CurrentUserId END,
            GETDATE(),
            CASE WHEN @CurrentUserId = -1 THEN NULL ELSE @CurrentUserId END,
            GETDATE()
        )

        SELECT SCOPE_IDENTITY()
    END
END
GO
