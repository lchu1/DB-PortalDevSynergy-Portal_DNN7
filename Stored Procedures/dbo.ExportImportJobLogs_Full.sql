SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImportJobLogs_Full]
    @JobId  int
AS
BEGIN
	SELECT
		*
	FROM
		dbo.[ExportImportJobLogs]
	WHERE
		JobId = @JobId
END
GO
