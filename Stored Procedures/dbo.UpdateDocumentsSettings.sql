SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[UpdateDocumentsSettings]
	@ModuleId          INT,
	@ShowTitleLink     BIT,
	@SortOrder         NVARCHAR(2000),
	@DisplayColumns    NVARCHAR(2000),
	@UseCategoriesList BIT,
	@DefaultFolder     NVARCHAR(2000),
	@CategoriesListName NVARCHAR(50),
	@AllowUserSort     BIT

AS
UPDATE dbo.DocumentsSettings
SET    ShowTitleLink=@ShowTitleLink,
       SortOrder=@SortOrder,    
       DisplayColumns=@DisplayColumns,
       UseCategoriesList=@UseCategoriesList,
       DefaultFolder=@DefaultFolder,
       CategoriesListName=@CategoriesListName,
       AllowUserSort=@AllowUserSort
WHERE  ModuleId = @ModuleId
GO
