SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_TabSettings]
	@TabID     int,
	@ToDate  datetime,
	@FromDate datetime=NULL
AS
BEGIN
	DECLARE @Now datetime = GETDATE()

	SELECT
		ts.*, u1.Username AS CreatedByUserName, u2.Username AS LastModifiedByUserName
	FROM
		dbo.TabSettings AS ts
			LEFT OUTER JOIN dbo.Users AS u1 ON ts.CreatedByUserID = u1.UserID
			LEFT OUTER JOIN dbo.Users AS u2 ON ts.LastModifiedByUserID = u2.UserID
	WHERE
		TabID = @TabID
	AND
		COALESCE(ts.LastModifiedOnDate, ts.CreatedOnDate, @Now) <= @ToDate
	AND
		(@FromDate IS NULL OR ISNULL(ts.LastModifiedOnDate, ts.CreatedOnDate) >= @FromDate)
END
GO
