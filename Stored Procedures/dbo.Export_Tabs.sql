SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_Tabs]
    @PortalID        int,
	@IncludeDeleted  bit,
    @IncludeSystem   bit,
	@ToDate          datetime,
	@FromDate        datetime=NULL
AS
BEGIN
	DECLARE @Now datetime = GETDATE()

	SELECT DISTINCT
		t.TabID, IsNull(t.ParentId, -1) AS ParentId, t.IsSystem, t.IsDeleted
	FROM
		dbo.Tabs t
			LEFT JOIN dbo.TabModules AS tm ON t.TabID = tm.TabID
	WHERE
		PortalID = @PortalID
	AND
		IsSystem = @IncludeSystem
	AND 
		(@IncludeDeleted = 1 OR t.IsDeleted = 0)
	AND (
			(COALESCE(t.LastModifiedOnDate, t.CreatedOnDate, @Now) <= @ToDate AND (@FromDate IS NULL OR ISNULL(t.LastModifiedOnDate, t.CreatedOnDate) >= @FromDate))
		 OR
			(COALESCE(tm.LastModifiedOnDate, tm.CreatedOnDate, @Now) <= @ToDate AND (@FromDate IS NULL OR ISNULL(tm.LastModifiedOnDate, tm.CreatedOnDate) >= @FromDate))
		)
	ORDER BY
		t.TabID
END
GO
