SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[AddPasswordHistory]
	@UserId             int,
	@Password           nvarchar(128),
	@PasswordSalt       nvarchar(128),
	@PasswordsRetained  int,
	@DaysRetained       int,
	@CreatedByUserID    int
AS

	BEGIN

	INSERT INTO dbo.PasswordHistory (
		UserId,
		[Password],
		PasswordSalt,
		CreatedByUserID,
		CreatedOnDate,
		LastModifiedByUserID,
		LastModifiedOnDate
	)
	VALUES (
		@UserId,
		@Password,
		@PasswordSalt,
		@CreatedByUserID,
		GETDATE(),
		@CreatedByUserID,
		GETDATE()
	)

	DELETE FROM dbo.PasswordHistory
	WHERE UserID=@UserId
	  AND PasswordHistoryID NOT IN (
		SELECT TOP (@PasswordsRetained) PasswordHistoryID
		FROM dbo.PasswordHistory
		WHERE UserID=@UserId
		ORDER BY CreatedOnDate DESC
		)
	  AND DATEDIFF(day, CreatedOnDate, GETDATE()) > @DaysRetained

	END
GO
