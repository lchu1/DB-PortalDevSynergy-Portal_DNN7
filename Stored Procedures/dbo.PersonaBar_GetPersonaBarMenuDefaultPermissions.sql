SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_GetPersonaBarMenuDefaultPermissions]
    @MenuId INT
AS
	SELECT RoleNames FROM dbo.[PersonaBarMenuDefaultPermissions] WHERE MenuId = @MenuId
GO
