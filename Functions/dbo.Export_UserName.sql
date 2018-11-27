SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[Export_UserName]
(
	@userId Int
)
RETURNS
	nVarChar(255)
AS
BEGIN
	DECLARE @Username AS nVarChar(255)

	SELECT  @Username = Username FROM dbo.[Users] WHERE UserID = @UserId
	RETURN  @Username
END
GO
