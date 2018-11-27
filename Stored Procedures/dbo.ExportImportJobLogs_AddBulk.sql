SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImportJobLogs_AddBulk]
	@DataTable dbo.[ExportImportJobLogsType] READONLY
AS
BEGIN
	INSERT INTO dbo.ExportImportJobLogs (
			[JobId],
			[Name],
			[Value],
			[Level],
			[CreatedOnDate] )
		SELECT
			dt.[JobId],
			dt.[Name],
			dt.[Value],
			dt.[Level],
			dt.[CreatedOnDate]
		FROM
			@DataTable dt
END
GO
