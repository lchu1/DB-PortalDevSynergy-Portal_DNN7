SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DeleteFolder]	
    @PortalID int,
    @FolderPath nvarchar(300)
AS
BEGIN
    SET NOCOUNT OFF;
	DECLARE @ParentID int;

	IF @PortalID is null
    BEGIN
		SELECT @ParentID=ParentID FROM dbo.[Folders] WHERE PortalID = @PortalID AND FolderPath = @FolderPath;
	    DELETE FROM dbo.[Folders] WHERE PortalID is null AND FolderPath = @FolderPath
    END 
	ELSE 
	BEGIN
		SELECT @ParentID=ParentID FROM dbo.[Folders] WHERE PortalID is null AND FolderPath = @FolderPath;
        DELETE FROM dbo.[Folders] WHERE PortalID = @PortalID AND FolderPath = @FolderPath
    END

	--UPDATE THE PARENT FOLDERS UPDATED DATE TO LASTET DATE
	IF(@@ROWCOUNT>0 AND @ParentID IS NOT NULL)
	BEGIN
		EXEC dbo.[UpdateFolderModifiedOnToCurrentDate] @ParentID
	END

END
GO
