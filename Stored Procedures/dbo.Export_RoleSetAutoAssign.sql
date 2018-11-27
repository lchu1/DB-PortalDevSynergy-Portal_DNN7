SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_RoleSetAutoAssign]
	@RoleID int
AS
	UPDATE
		dbo.Roles
	SET
		AutoAssignment = 1
	WHERE
		RoleID = @RoleID
GO
