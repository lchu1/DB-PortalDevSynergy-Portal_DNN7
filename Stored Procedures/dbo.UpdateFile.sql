SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[UpdateFile]
    @FileId                 Int,
    @VersionGuid            UniqueIdentifier,
    @FileName               nVarChar(246),
    @Extension              nVarChar(100),
    @Size                   Int,
    @Width                  Int,
    @Height                 Int,
    @ContentType            nVarChar(200),
    @FolderID               Int,
    @LastModifiedByUserID   Int,
    @Hash                   VarChar(40),
    @LastModificationTime   DateTime,
    @Title                  nVarChar(256),
    @Description            nVarChar(500),
    @EnablePublishPeriod    Bit,
    @StartDate              DateTime,
    @EndDate                DateTime,
    @ContentItemID          Int
AS
BEGIN
    SET NOCOUNT OFF;
    DECLARE @PortalID int;
    SELECT @PortalID = PortalID FROM dbo.[Folders] WHERE FolderID = @FolderID;
    UPDATE dbo.[Files]
     SET   FileName             = @FileName,
           VersionGuid          = @VersionGuid,
           Extension            = @Extension,
           Size                 = @Size,
           Width                = @Width,
           Height               = @Height,
           ContentType          = @ContentType,
           FolderID             = @FolderID,
           PortalID             = @PortalID,
           LastModifiedByUserID = @LastModifiedByUserID,
           LastModifiedOnDate   = GetDate(),
           SHA1Hash             = @Hash,
           LastModificationTime = @LastModificationTime,
           Title                = @Title,
           Description          = @Description,
           EnablePublishPeriod  = @EnablePublishPeriod,
           StartDate            = @StartDate,
           EndDate              = @EndDate,
           ContentItemID        = @ContentItemID
     WHERE FileId = @FileId
    
	--UPDATE THE PARENT FOLDERS UPDATED DATE TO LASTET DATE
	IF(@@ROWCOUNT>0 AND @FolderID IS NOT NULL)
	BEGIN
		EXEC dbo.[UpdateFolderModifiedOnToCurrentDate] @FolderID
	END

END
GO
