SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImportJobs_FirstActive]
AS
BEGIN
	SELECT
		TOP(1) Jobs.*
	FROM
		dbo.[ExportImportJobs] Jobs
		INNER JOIN dbo.[Portals] Portals ON Portals.PortalID=Jobs.PortalId
	WHERE
		JobStatus in (0, 1) -- 0=Submitted, 1=InProgress
	ORDER BY
		JobId ASC
END
GO
