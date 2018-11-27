SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetCategoriesByEntry]
 @PortalId INT,
 @EntryId INT,
 @Locale NVARCHAR(6)
AS
SELECT
 c.CategoryId, c.ParentId, c.PortalId, c.ViewOrder,
 ISNULL(cl.[CategoryName], c.CategoryName) CategoryName
FROM dbo.DMX_Categories c
 INNER JOIN dbo.DMX_EntryCategories ec ON c.CategoryId=ec.CategoryId AND ec.EntryId=@EntryId
 LEFT JOIN dbo.DMX_CategoriesML cl ON c.CategoryId=cl.CategoryId AND cl.Locale=@Locale
WHERE c.PortalId=@PortalID
ORDER BY ParentId, ViewOrder
GO
