SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImportJobs_GetById]
    @JobId  int
AS
BEGIN
	SELECT
		*
	FROM
		dbo.[ExportImportJobs]
	WHERE
		JobId = @JobId
END
GO
