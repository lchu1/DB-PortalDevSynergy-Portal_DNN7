SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImportCheckpoints_GetByJob]
	@JobId		int
AS
BEGIN
	SELECT
		*
	FROM
		dbo.[ExportImportCheckpoints]
	WHERE
		JobId = @JobId
END
GO
