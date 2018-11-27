SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImportJobs_UpdateInfo]
	@JobId       int,
	@JobName     nvarchar(100),
	@Description nvarchar(250)
AS
BEGIN
	UPDATE
		dbo.[ExportImportJobs]
	SET
		[Name] = @JobName,
		[Description] = GetUtcDate()
	WHERE
		JobId = @JobId
END
GO
