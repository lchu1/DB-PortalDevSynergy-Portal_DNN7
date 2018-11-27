SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImportJobs_GetAll]
    @PortalID  int = -1, -- might be null or -1 for all portals
    @PageSize  int = 10, -- number of items per page
    @PageIndex int =  0, -- page number starting at 0
	@JobType   int = NULL,
	@Keywords  nvarchar(100) = NULL
AS
BEGIN
	SET @PortalId = IsNull(@PortalId, -1)
	SET @PageSize = IsNull(@PageSize, 10)
	SET @PageIndex = IsNull(@PageIndex, 0)

	; WITH AllJobs AS (
		SELECT
			ROW_NUMBER() OVER (ORDER BY JobId DESC) AS RowNum, Jobs.*
		FROM
			dbo.ExportImportJobs Jobs
		INNER JOIN dbo.Portals Portals ON Portals.PortalID=Jobs.PortalId
		WHERE
			(Jobs.PortalID = @PortalID OR @PortalID=-1)
		AND
			(@JobType IS NULL OR JobType = @JobType)
		AND
			(   @Keywords IS NULL
			 OR [Name] LIKE ('%' + @Keywords + '%')
			 OR [Description] LIKE ('%' + @Keywords + '%') )
	)
	SELECT
		TOP(@PageSize) *
	FROM
		AllJobs
	WHERE
		RowNum >= (@PageIndex * @PageSize + 1)
END
GO
