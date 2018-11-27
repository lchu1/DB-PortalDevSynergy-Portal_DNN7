SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_ModuleSettings]
	@ModuleID  int,
	@ToDate    datetime,
	@FromDate  datetime=NULL
AS
BEGIN
	DECLARE @Now datetime = GETDATE()

	SELECT
		ms.*, u1.Username AS CreatedByUserName, u2.Username AS LastModifiedByUserName
	FROM
		dbo.ModuleSettings AS ms
			INNER JOIN dbo.Modules    AS m  ON ms.ModuleID = m.ModuleID
			LEFT OUTER JOIN dbo.Users AS u1 ON ms.CreatedByUserID = u1.UserID
			LEFT OUTER JOIN dbo.Users AS u2 ON ms.LastModifiedByUserID = u2.UserID
	WHERE
		m.ModuleID = @ModuleID
	AND
		COALESCE(ms.LastModifiedOnDate, ms.CreatedOnDate, @Now) <= @ToDate
	AND
		(@FromDate IS NULL OR ISNULL(ms.LastModifiedOnDate, ms.CreatedOnDate) >= @FromDate)
END
GO
