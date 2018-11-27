SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImportCheckpoints_Upsert]
	@JobId			int,
	@AssemblyName	nvarchar(200),
	@Category		nvarchar(50),
	@Stage			int,
	@StageData		nvarchar(max),
	@Progress		int,
	@TotalItems		int,
	@ProcessedItems int,
	@StartDate		DateTime = NULL,
	@Completed		bit = 0
AS
BEGIN
	MERGE INTO dbo.[ExportImportCheckpoints] target
	 USING (SELECT @JobId, @AssemblyName, @Category, @Progress, @TotalItems, @ProcessedItems, @Completed) AS source (JobId, AssemblyName, Category, Progress, TotalItems, ProcessedItems, Completed)
		ON (target.JobId = source.JobId AND target.Category = source.Category AND target.AssemblyName = source.AssemblyName)
	 WHEN MATCHED THEN
		UPDATE SET [Stage] = @Stage, [StageData] = @StageData, [Progress] = @Progress, [TotalItems] = @TotalItems, [ProcessedItems] = @ProcessedItems, StartDate=(CASE WHEN StartDate IS NULL THEN @StartDate ELSE StartDate END),  LastUpdateDate= GetUtcDate(), Completed=@Completed
	 WHEN NOT MATCHED THEN 
		INSERT ([JobId], [AssemblyName], [Category], [Stage], [StageData], [Progress], [TotalItems], [ProcessedItems])
		VALUES (@JobId, @AssemblyName, @Category,  @Stage,  @StageData, @Progress, @TotalItems, @ProcessedItems);
END
GO
