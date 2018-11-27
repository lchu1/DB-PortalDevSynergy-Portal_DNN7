SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetSubCategories]
 @PortalId INT,
 @CategoryId INT,
 @Locale NVARCHAR(6)
AS
SELECT
 c.CategoryId, c.ParentId, c.PortalId, c.ViewOrder,
 ISNULL(cl.[CategoryName], c.CategoryName) CategoryName
FROM dbo.DMX_Categories c
 LEFT JOIN dbo.DMX_CategoriesML cl ON c.CategoryId=cl.CategoryId AND cl.Locale=@Locale
WHERE c.PortalId=@PortalID
 AND c.ParentId=@CategoryId
ORDER BY ViewOrder, CategoryName
GO
