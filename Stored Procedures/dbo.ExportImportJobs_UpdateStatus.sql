SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImportJobs_UpdateStatus]
	@JobId int,
	@JobStatus int,
	@CompletedOn datetime = NULL
AS
BEGIN
	UPDATE
		dbo.[ExportImportJobs]
	SET
		JobStatus = @JobStatus,
		LastModifiedOnDate = GetUtcDate(),
		CompletedOnDate = @CompletedOn
	WHERE
		JobId = @JobId
END
GO
