SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_ModulePermissions]
	@ModuleID  int,
	@ToDate    datetime,
	@FromDate  datetime=NULL
AS
BEGIN
	DECLARE @Now datetime = GETDATE()

	SELECT
		mp.*, u1.Username AS CreatedByUserName, u2.Username AS LastModifiedByUserName
	FROM
		dbo.vw_ModulePermissions      AS mp
			LEFT OUTER JOIN dbo.Users AS u1 ON mp.CreatedByUserID = u1.UserID
			LEFT OUTER JOIN dbo.Users AS u2 ON mp.LastModifiedByUserID = u2.UserID
	WHERE
		ModuleID = @ModuleID
	AND
		COALESCE(mp.LastModifiedOnDate, mp.CreatedOnDate, @Now) <= @ToDate
	AND
		(@FromDate IS NULL OR ISNULL(mp.LastModifiedOnDate, mp.CreatedOnDate) >= @FromDate)
END
GO
