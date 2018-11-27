SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_ContentWorkflowStatePermissions]
	@StateID  int,
	@ToDate   datetime,
	@FromDate datetime=NULL
AS
BEGIN
	DECLARE @Now datetime = GETDATE()

	SELECT
		wp.*, u1.Username AS CreatedByUserName, u2.Username AS LastModifiedByUserName
	FROM
		dbo.vw_ContentWorkflowStatePermissions AS wp
			LEFT OUTER JOIN dbo.ContentWorkflowStates AS ws ON wp.StateID = ws.StateID
			LEFT OUTER JOIN dbo.Users AS u1 ON wp.CreatedByUserID = u1.UserID
			LEFT OUTER JOIN dbo.Users AS u2 ON wp.LastModifiedByUserID = u2.UserID
	WHERE
		ws.StateID = @StateID
	AND
		COALESCE(wp.LastModifiedOnDate, wp.CreatedOnDate, @Now) <= @ToDate
	AND
		(@FromDate IS NULL OR ISNULL(wp.LastModifiedOnDate, wp.CreatedOnDate) >= @FromDate)
END
GO
