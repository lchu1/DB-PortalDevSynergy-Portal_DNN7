SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetPasswordHistory]
	@UserID             int,
	@PasswordsRetained  int,
	@DaysRetained       int
AS
	SELECT TOP (@PasswordsRetained) *
	FROM dbo.PasswordHistory
	WHERE UserID=@UserID
	  AND DATEDIFF(day, CreatedOnDate, GETDATE()) <= @DaysRetained;
GO
