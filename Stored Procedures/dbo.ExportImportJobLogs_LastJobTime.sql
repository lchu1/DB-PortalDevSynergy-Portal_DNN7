SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImportJobLogs_LastJobTime]
    @PortalId  int,
	@JobType int
AS
BEGIN
	SELECT
		TOP 1 CreatedOnDate AS LastExportTime
	FROM
		dbo.[ExportImportJobs]
	WHERE 
		PortalId=@PortalId AND JobType = @JobType AND JobStatus=2
	ORDER BY CreatedOnDate DESC
END
GO
