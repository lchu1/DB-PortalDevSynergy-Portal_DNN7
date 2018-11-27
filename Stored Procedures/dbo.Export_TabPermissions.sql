SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_TabPermissions]
	@TabID     int,
	@ToDate  datetime,
	@FromDate datetime=NULL
AS
BEGIN
	DECLARE @Now datetime = GETDATE()

	SELECT
		tp.*, md.FriendlyName, u1.Username AS CreatedByUserName, u2.Username AS LastModifiedByUserName
	FROM
		dbo.vw_TabPermissions AS tp
			LEFT OUTER JOIN dbo.ModuleDefinitions AS md ON md.ModuleDefID = tp.ModuleDefID
			LEFT OUTER JOIN dbo.Users AS u1 ON tp.CreatedByUserID = u1.UserID
			LEFT OUTER JOIN dbo.Users AS u2 ON tp.LastModifiedByUserID = u2.UserID
	WHERE
		TabID = @TabID
	AND
		COALESCE(tp.LastModifiedOnDate, tp.CreatedOnDate, @Now) <= @ToDate
	AND
		(@FromDate IS NULL OR ISNULL(tp.LastModifiedOnDate, tp.CreatedOnDate) >= @FromDate)
END
GO
