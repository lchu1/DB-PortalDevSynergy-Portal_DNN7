SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_UpdateUsersChangers]
	@UserID int,
	@CreatedByUserName nvarchar(100),
	@ModifiedByUserName nvarchar(100)
AS
	UPDATE
		dbo.Users
	SET
		CreatedByUserID = dbo.[Export_UserIdByUsername](@CreatedByUserName),
		LastModifiedByUserID = dbo.[Export_UserIdByUsername](@ModifiedByUserName)
	WHERE
		UserID = @UserID
GO
