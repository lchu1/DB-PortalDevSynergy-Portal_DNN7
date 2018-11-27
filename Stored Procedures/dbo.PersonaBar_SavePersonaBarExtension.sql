SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_SavePersonaBarExtension]
    @Identifier                 NVARCHAR(50),
    @MenuId                     INT,
    @FolderName                 NVARCHAR(50),
    @Controller                 NVARCHAR(260),
    @Container                  NVARCHAR(50),
    @Path                       NVARCHAR(260),
    @Order                      INT,
    @Enabled                    BIT,
    @CurrentUserId              INT
AS
BEGIN
    IF EXISTS(SELECT ExtensionId FROM dbo.[PersonaBarExtensions] WHERE Identifier = @Identifier)
    BEGIN
        UPDATE dbo.[PersonaBarExtensions]
            SET 
                MenuId = @MenuId,
                FolderName = @FolderName,
                Controller = @Controller,
                Container = @Container,
                Path = @Path,
                [Order] = @Order,
                Enabled = @Enabled
            WHERE Identifier = @Identifier

            SELECT ExtensionId FROM dbo.[PersonaBarExtensions] WHERE Identifier = @Identifier
    END
    ELSE
    BEGIN
        INSERT INTO dbo.[PersonaBarExtensions] (
            [Identifier],
            [MenuId],
            [FolderName],
            [Controller],
            [Container],
            [Path],
            [Order],
            [Enabled]
        ) VALUES (
            @Identifier,
            @MenuId,
            @FolderName,
            @Controller,
            @Container,
            @Path,
            @Order,
            @Enabled
        )

        SELECT SCOPE_IDENTITY()
    END
END
GO
