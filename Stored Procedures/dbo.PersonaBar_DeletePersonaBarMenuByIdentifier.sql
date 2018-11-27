SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_DeletePersonaBarMenuByIdentifier]
    @Identifier  NVARCHAR(50)
AS
    DELETE p FROM dbo.[PersonaBarPermission] p
        INNER JOIN dbo.[PersonaBarMenu] m ON m.MenuId = p.MenuId
        WHERE m.Identifier = @Identifier

    DELETE FROM dbo.[PersonaBarMenu]
        WHERE Identifier = @Identifier
GO
