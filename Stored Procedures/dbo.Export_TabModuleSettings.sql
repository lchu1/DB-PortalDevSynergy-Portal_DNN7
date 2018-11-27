SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_TabModuleSettings]
	@TabID          int,
	@ToDate         datetime,
	@FromDate       datetime=NULL
AS
BEGIN
	DECLARE @Now datetime = GETDATE()
	SELECT ModuleId INTO #ActiveModuleIds FROM dbo.[Export_GetActiveTabModules](@TabID)

	SELECT
		tms.*, u1.Username AS CreatedByUserName, u2.Username AS LastModifiedByUserName
	FROM
		dbo.TabModuleSettings AS tms
			INNER JOIN dbo.TabModules AS tm ON tm.TabModuleID = tms.TabModuleID
			INNER JOIN dbo.Tabs       AS t  ON tm.TabID = t.TabID
			LEFT OUTER JOIN dbo.Users AS u1 ON tm.CreatedByUserID = u1.UserID
			LEFT OUTER JOIN dbo.Users AS u2 ON tm.LastModifiedByUserID = u2.UserID
	WHERE
		t.TabID = @TabID AND tm.ModuleID IN (SELECT ModuleId FROM #ActiveModuleIds)
	AND
		COALESCE(tms.LastModifiedOnDate, tms.CreatedOnDate, @Now) <= @ToDate
	AND
		(@FromDate IS NULL OR ISNULL(tms.LastModifiedOnDate, tms.CreatedOnDate) >= @FromDate)

	DROP TABLE #ActiveModuleIds
END
GO
