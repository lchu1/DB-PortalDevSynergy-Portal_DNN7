SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Personabar_GetUsersByUserIds] (
	@PortalId INT,
	@UserIds nvarchar(max) -- comma separated list of UserIds
) AS
BEGIN
		SELECT DISTINCT U.UserID, U.Username, U.DisplayName, U.Email, U.CreatedOnDate, U.IsDeleted, U.Authorised
		FROM dbo.vw_Users U WITH (NOLOCK)
		INNER JOIN (Select RowValue FROM dbo.ConvertListToTable(',',@UserIds)) UserIds
			ON U.UserID = UserIds.RowValue
		INNER JOIN dbo.UserPortals UP WITH (NOLOCK)
			ON U.UserID = UP.UserId
		WHERE UP.PortalId = @PortalId
END
GO
