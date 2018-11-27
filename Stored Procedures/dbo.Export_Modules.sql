SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_Modules]
	@TabID          int,
	@IncludeDeleted bit,
	@ToDate         datetime,
	@FromDate       datetime=NULL
AS
BEGIN
	DECLARE @Now datetime = GETDATE()
	SELECT ModuleId INTO #ActiveModuleIds FROM dbo.[Export_GetActiveTabModules](@TabID)

	SELECT DISTINCT
		m.*, md.FriendlyName, u1.Username AS CreatedByUserName, u2.Username AS LastModifiedByUserName
	FROM
		dbo.Modules AS m
			INNER JOIN dbo.TabModules        AS tm ON tm.ModuleID = m.ModuleID
			INNER JOIN dbo.ModuleDefinitions AS md ON md.ModuleDefID = m.ModuleDefID
			LEFT OUTER JOIN dbo.Users        AS u1 ON tm.CreatedByUserID = u1.UserID
			LEFT OUTER JOIN dbo.Users        AS u2 ON tm.LastModifiedByUserID = u2.UserID
	WHERE
		tm.TabID = @TabID AND tm.ModuleID IN (SELECT ModuleId FROM #ActiveModuleIds)
	AND
		(@IncludeDeleted = 1 OR m.IsDeleted = 0)
	AND (
			COALESCE(m.LastModifiedOnDate, m.CreatedOnDate, @Now) <= @ToDate AND (@FromDate IS NULL OR ISNULL(m.LastModifiedOnDate, m.CreatedOnDate) >= @FromDate)
		OR
			COALESCE(tm.LastModifiedOnDate, tm.CreatedOnDate, @Now) <= @ToDate AND (@FromDate IS NULL OR ISNULL(tm.LastModifiedOnDate, tm.CreatedOnDate) >= @FromDate)
		)
	DROP TABLE #ActiveModuleIds
END
GO
