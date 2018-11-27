SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImportJobs_Add]
	@PortalId    int,
	@JobType     int,
	@CreatedBy   int,
	@JobName     nvarchar(100),
	@Description nvarchar(250),
	@Directory   nvarchar(100),
	@JobObject   nvarchar(max)
AS
BEGIN
	INSERT INTO
		dbo.[ExportImportJobs]
		(
			[PortalId],
			[JobType],
			[Name],
			[Description],
			[CreatedByUserID],
			[Directory],
			[JobObject]
		)
	VALUES
		(
			IsNull(@PortalId, -1),
			@JobType,
			@JobName,
			@Description,
			IsNull(@CreatedBy, -1),
			@Directory,
			@JobObject
		)

	SELECT SCOPE_IDENTITY()
END
GO
