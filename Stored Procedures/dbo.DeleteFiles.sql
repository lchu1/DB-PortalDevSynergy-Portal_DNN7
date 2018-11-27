SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DeleteFiles]	
    @PortalID int
AS
BEGIN
    SET NOCOUNT OFF;
	DECLARE @FolderID int;

    IF @PortalID is null
    BEGIN
		SELECT TOP 1 @FolderID=FolderID FROM dbo.[Files] WHERE PortalId is null
        DELETE FROM dbo.[Files] WHERE PortalId is null
    END 
	ELSE 
	BEGIN
		SELECT TOP 1 @FolderID=FolderID FROM dbo.[Files] WHERE PortalId = @PortalID
        DELETE FROM dbo.[Files] WHERE PortalId = @PortalID
    END

	--UPDATE THE PARENT FOLDERS UPDATED DATE TO LASTET DATE
	IF(@@ROWCOUNT>0 AND @FolderID IS NOT NULL)
	BEGIN
		EXEC dbo.[UpdateFolderModifiedOnToCurrentDate] @FolderID
	END

END
GO
