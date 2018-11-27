SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[UpdateUserLastIpAddress] 
	@UserID         int,
	@LastIPAddress	nvarchar(50)
AS
	UPDATE dbo.[Users] 
	SET	LastIPAddress = @LastIPAddress
	WHERE  UserId = @UserID
GO
