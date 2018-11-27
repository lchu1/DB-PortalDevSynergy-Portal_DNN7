SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[UpdateFolderModifiedOnToCurrentDate]
    @FolderID	Int
AS
BEGIN
	SET NOCOUNT OFF;
	--Update the folder only if it has LastModifiedOnDate more than 59 secs old.
	--This is to avoid too many updates during massive sync
	UPDATE dbo.[Folders] SET LastModifiedOnDate=GETDATE() WHERE FolderID=@FolderID AND DATEDIFF(SECOND,LastModifiedOnDate,GETDATE())>=60
	IF(@@ROWCOUNT>0)
	BEGIN
		--Check if the parent also needs updation
		DECLARE @ParentID Int;
		SELECT @ParentID = ParentID FROM dbo.[Folders] WHERE FolderID=@FolderID
		IF(@ParentID>0)
		BEGIN
			EXEC dbo.[UpdateFolderModifiedOnToCurrentDate] @ParentID
		END
	END
END
GO
