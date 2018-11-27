SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[Export_UserIdByUsername]
(
	@username nvarchar(100)
)
RETURNS
	int
AS
BEGIN
	DECLARE @UserId AS int

	SELECT  @UserId = UserID FROM dbo.[Users] WHERE Username = @username
	IF(@UserId IS NULL)
	BEGIN
		RETURN -1;
	END
	RETURN @UserId;
END
GO
