SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_TabUrls]
	@TabID     int,
	@ToDate  datetime,
	@FromDate datetime=NULL
AS
BEGIN
	DECLARE @Now datetime = GETDATE()

	SELECT
		tu.*, pa.HTTPAlias, u1.Username AS CreatedByUserName, u2.Username AS LastModifiedByUserName
	FROM
		dbo.TabUrls as tu
			LEFT OUTER JOIN dbo.PortalAlias AS pa ON tu.PortalAliasId = pa.PortalAliasID
			LEFT OUTER JOIN dbo.Users       AS u1 ON tu.CreatedByUserID = u1.UserID
			LEFT OUTER JOIN dbo.Users       AS u2 ON tu.LastModifiedByUserID = u2.UserID
	WHERE
		tu.TabID = @TabID
	AND
		COALESCE(tu.LastModifiedOnDate, tu.CreatedOnDate, @Now) <= @ToDate
	AND
		(@FromDate IS NULL OR ISNULL(tu.LastModifiedOnDate, tu.CreatedOnDate) >= @FromDate)
END
GO
