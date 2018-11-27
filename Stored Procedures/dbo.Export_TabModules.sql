SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_TabModules]
	@TabID          int,
	@IncludeDeleted bit,
	@ToDate         datetime,
	@FromDate       datetime=NULL
AS
BEGIN
	DECLARE @Now datetime = GETDATE()
	SELECT ModuleId INTO #ActiveModuleIds FROM dbo.[Export_GetActiveTabModules](@TabID)

	SELECT
		tm.*, md.FriendlyName,m.InheritViewPermissions,m.IsShareable,m.IsShareableViewOnly, u1.Username AS CreatedByUserName, u2.Username AS LastModifiedByUserName
	FROM
		dbo.TabModules AS tm
			INNER JOIN dbo.Tabs              AS t  ON tm.TabID = t.TabID
			INNER JOIN dbo.Modules           AS m  ON tm.ModuleID = m.ModuleID 
			INNER JOIN dbo.ModuleDefinitions AS md ON md.ModuleDefID = m.ModuleDefID 
			LEFT OUTER JOIN dbo.Users        AS u1 ON tm.CreatedByUserID = u1.UserID
			LEFT OUTER JOIN dbo.Users        AS u2 ON tm.LastModifiedByUserID = u2.UserID
	WHERE
		tm.TabID = @TabID AND tm.ModuleID IN (SELECT ModuleId FROM #ActiveModuleIds)
	AND
		(@IncludeDeleted = 1 OR tm.IsDeleted = 0)
	AND
		COALESCE(tm.LastModifiedOnDate, tm.CreatedOnDate, @Now) <= @ToDate
	AND
		(@FromDate IS NULL OR ISNULL(tm.LastModifiedOnDate, tm.CreatedOnDate) >= @FromDate)
	
	DROP TABLE #ActiveModuleIds
END
GO
