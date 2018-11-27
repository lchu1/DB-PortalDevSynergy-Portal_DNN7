SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[AddDocumentsSettings]
	@ModuleId          INT,
	@ShowTitleLink     BIT,
	@SortOrder         NVARCHAR(2000),
	@DisplayColumns    NVARCHAR(2000),
	@UseCategoriesList BIT,
	@DefaultFolder     NVARCHAR(2000),
	@CategoriesListName NVARCHAR(50),
	@AllowUserSort     BIT

AS
INSERT INTO dbo.[DocumentsSettings] (
  ModuleId,
  ShowTitleLink,
  SortOrder,    
  DisplayColumns,
  UseCategoriesList,
  DefaultFolder,
  CategoriesListName,
  AllowUserSort
)
VALUES (
  @ModuleId,
  @ShowTitleLink,
  @SortOrder,    
  @DisplayColumns,
  @UseCategoriesList,
  @DefaultFolder,
  @CategoriesListName,
  @AllowUserSort
)
SELECT @ModuleId
GO
