SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImportJobs_Remove]
	@JobId int
AS
BEGIN
	-- deletion of logs will be cascaded
	DELETE FROM
		dbo.[ExportImportJobs]
	WHERE
		JobId = @JobId
END
GO
