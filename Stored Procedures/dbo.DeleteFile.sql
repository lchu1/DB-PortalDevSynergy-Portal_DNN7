SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DeleteFile]	
    @PortalID int,
	@FileName nvarchar(246),
	@FolderID int
AS
BEGIN
	SET NOCOUNT OFF;
    IF @PortalID is null
    BEGIN
        DELETE FROM dbo.[Files] WHERE FileName = @FileName AND FolderID = @FolderID AND PortalId IS Null
    END 
	ELSE 
	BEGIN
        DELETE FROM dbo.[Files] WHERE FileName = @FileName AND FolderID = @FolderID AND PortalId = @PortalID
    END
	
	--UPDATE THE PARENT FOLDERS UPDATED DATE TO LASTET DATE
	IF(@@ROWCOUNT>0 AND @FolderID IS NOT NULL)
	BEGIN
		EXEC dbo.[UpdateFolderModifiedOnToCurrentDate] @FolderID
	END
END
GO
