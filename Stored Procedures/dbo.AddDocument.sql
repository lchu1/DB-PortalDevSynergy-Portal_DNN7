SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[AddDocument]
	@ModuleId         INT,
	@Title            NVARCHAR(150),
	@URL              NVARCHAR(250),
	@UserId           INT,
	@OwnedByUserId    INT,
	@Category         NVARCHAR(50),
	@SortOrderIndex   INT, 
	@Description      NVARCHAR(255),
	@ForceDownload	BIT
AS
INSERT INTO dbo.Documents (
  ModuleId,
  Title,
  URL,
  CreatedByUserID,
  CreatedDate,
  Category,
  OwnedByUserID,
  ModifiedByUserID,
  ModifiedDate,
  SortOrderIndex,
  Description,
  ForceDownload
)
VALUES (
  @ModuleId,
  @Title,
  @URL,
  @UserId,
  getdate(),
  @Category,
  @OwnedByUserId,
  @UserId,
  getdate(),
  @SortOrderIndex,
  @Description,
  @ForceDownload
)
SELECT SCOPE_IDENTITY()
GO
