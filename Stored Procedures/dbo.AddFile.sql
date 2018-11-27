SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[AddFile]
	@PortalId   int,
	@UniqueId   uniqueidentifier,
	@VersionGuid  uniqueidentifier,
	@FileName   nvarchar(246),
	@Extension   nvarchar(100),
	@Size    int,
	@Width    int,
	@Height    int,
	@ContentType  nvarchar(200),
	@Folder    nvarchar(246),
	@FolderID   int,
	@CreatedByUserID   int,
	@Hash     varchar(40),
	@LastModificationTime	datetime, 
	@Title					nvarchar(256),
    @Description            nvarchar(500),
	@EnablePublishPeriod	bit,
	@StartDate				datetime,
	@EndDate				datetime,
	@ContentItemID			int
AS
BEGIN
	
	SET NOCOUNT OFF;
	DECLARE @FileID int

	UPDATE dbo.[Files]
	SET
		/* retrieves FileId from table */
		@FileID = FileId,
		FileName = @FileName,
		VersionGuid = @VersionGuid,
		Extension = @Extension,
		Size = @Size,
		Width = @Width,
		Height = @Height,
		ContentType = @ContentType,
		FolderID = @FolderID,
		LastModifiedByUserID = @CreatedByUserID,
		LastModifiedOnDate = getdate(),
		SHA1Hash = @Hash,
		LastModificationTime = @LastModificationTime, 
		Title = @Title,
        Description = @Description,
		EnablePublishPeriod = @EnablePublishPeriod,
		StartDate = @StartDate,
		EndDate = @EndDate,
		ContentItemID = @ContentItemID
	WHERE
		FolderID = @FolderID AND FileName = @FileName
	
	DECLARE @RowCount int = @@ROWCOUNT;
	IF @RowCount = 0
	BEGIN
	INSERT INTO dbo.[Files] (
		PortalId,
		UniqueId,
		VersionGuid,
		FileName,
		Extension,
		Size,
		Width,
		Height,
		ContentType,
		FolderID,
		CreatedByUserID,
		CreatedOnDate,
		LastModifiedByUserID,
		LastModifiedOnDate,
		SHA1Hash,
		LastModificationTime, 
		Title,
        Description,
		EnablePublishPeriod,
		StartDate,
		EndDate,
		ContentItemID
	)
	VALUES (
		@PortalId,
		@UniqueId,
		@VersionGuid,
		@FileName,
		@Extension,
		@Size,
		@Width,
		@Height,
		@ContentType,
		@FolderID,
		@CreatedByUserID,
		getdate(),
		@CreatedByUserID,
		getdate(),
		@Hash,
		@LastModificationTime, 
		@Title,
        @Description,
		@EnablePublishPeriod,
		@StartDate,
		@EndDate,
		@ContentItemID
	)
	SELECT @FileID = SCOPE_IDENTITY()
	END

	--UPDATE THE PARENT FOLDERS UPDATED DATE TO LATEST DATE
	IF((@RowCount>0 OR @@ROWCOUNT>0) AND @FolderID IS NOT NULL)
	BEGIN
		EXEC dbo.[UpdateFolderModifiedOnToCurrentDate] @FolderID
	END
	
	SELECT @FileID

END
GO
