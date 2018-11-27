SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_RoleIdByName]
	@PortalID  int = NULL,
	@RoleName  nvarchar(50)
AS
BEGIN
	DECLARE @RoleId int;
	SELECT TOP 1 @RoleId=RoleID FROM 
		dbo.Roles
	WHERE
		(PortalID = @PortalID OR @PortalID IS NULL) AND RoleName=@RoleName
	IF @RoleId IS NULL
	BEGIN
		SET @RoleId = -4;
	END
	SELECT @RoleId;
END
GO
