SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_GetPermissionInfo]
	@PermissionCode  varchar(50),
	@PermissionKey   varchar(50),
	@PermissionName  varchar(50)
AS
BEGIN
	SELECT
		*
	FROM
		dbo.Permission
	WHERE
		PermissionCode = @PermissionCode
	AND
		PermissionKey = @PermissionKey
	AND
		PermissionName = @PermissionName
END
GO
