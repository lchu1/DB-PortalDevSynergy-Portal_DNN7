SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_SetUserDeleted]
	@PortalID   int,
	@UserID     int,
	@IsDeleted  bit
AS
BEGIN
    UPDATE dbo.UserPortals
    SET IsDeleted = @IsDeleted
    WHERE PortalID = @PortalID AND UserID = @UserID
END
GO
