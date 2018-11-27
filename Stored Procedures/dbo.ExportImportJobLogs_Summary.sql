SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImportJobLogs_Summary]
    @JobId  int
AS
BEGIN
	SELECT
		*
	FROM
		dbo.[ExportImportJobLogs]
	WHERE
		JobId = @JobId
	  AND
		Level >= 1
END
GO
