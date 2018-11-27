SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetCategoryLocalizations]
 @CategoryId INT
AS
SELECT *
FROM dbo.DMX_CategoriesML
WHERE [CategoryId] = @CategoryId
GO
