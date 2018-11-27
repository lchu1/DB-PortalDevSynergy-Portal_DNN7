SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_DeletePersonaBarExtension]
    @Identifier NVARCHAR(50)
AS
	DELETE FROM dbo.[PersonaBarExtensions] WHERE Identifier = @Identifier
GO
