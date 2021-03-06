SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetCategoriesByPortal]
 @PortalId INT,
 @Locale NVARCHAR(10)
AS
SELECT
 c.CategoryId, c.ParentId, c.PortalId, c.ViewOrder,
 ISNULL(cl.[CategoryName], c.CategoryName) CategoryName
FROM
 dbo.DMX_Categories c
 LEFT JOIN dbo.DMX_CategoriesML cl ON c.CategoryId=cl.CategoryId AND cl.Locale=@Locale
WHERE
 c.PortalId = @PortalId
ORDER BY
 c.ParentId, c.ViewOrder
GO
