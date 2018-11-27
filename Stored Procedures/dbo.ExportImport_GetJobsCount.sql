SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImport_GetJobsCount]
    @PortalID  int,
	@JobType   int = NULL,
	@Keywords  nvarchar(100) = NULL
AS
	SELECT
		Count(*)
	FROM
		dbo.ExportImportJobs J
	INNER JOIN dbo.Portals Portals ON Portals.PortalID=J.PortalId
	WHERE
		(J.PortalID = @PortalID OR @PortalID=-1)
	AND
		(@JobType IS NULL OR JobType = @JobType)
	AND
		(   @Keywords IS NULL
		 OR [Name] LIKE ('%' + @Keywords + '%')
		 OR [Description] LIKE ('%' + @Keywords + '%') )
GO
