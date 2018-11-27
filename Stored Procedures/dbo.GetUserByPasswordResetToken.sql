SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetUserByPasswordResetToken]
	@PortalID int,
	@PasswordResetToken UNIQUEIDENTIFIER

AS
	SELECT * FROM dbo.vw_Users
	WHERE  PasswordResetToken = @PasswordResetToken
		AND  ((@PortalId IS NULL) OR (PortalId = @PortalID) OR IsSuperUser = 1)
GO
