SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImportJobs_SetCancelled]
	@JobId int
AS
BEGIN
	UPDATE
		dbo.[ExportImportJobs]
	SET
		IsCancelled = 1,
		LastModifiedOnDate = GetUtcDate()
	WHERE
		JobId = @JobId
END
GO
