SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[UpdateDocument]
	@ModuleId		  INT,
	@ItemId           INT,
	@Title            nvarchar(150),
	@URL              nvarchar(250),
	@UserId           INT,
	@Category         nvarchar(50),
	@OwnedByUserID    INT,
	@SortOrderIndex   INT, 
	@Description      nvarchar(255),
	@ForceDownload BIT
AS
UPDATE dbo.Documents
SET    Title             = @Title,
       URL               = @URL,
       Category          = @Category,
       OwnedByUserID     = @OwnedByUserID,
       ModifiedByUserID  = @UserId,
       ModifiedDate      = getdate(),
       SortOrderIndex    = @SortOrderIndex,
       Description       = @Description,
	   ForceDownload	 = @ForceDownload
WHERE  ItemId = @ItemId
	AND ModuleId = @ModuleId
GO
