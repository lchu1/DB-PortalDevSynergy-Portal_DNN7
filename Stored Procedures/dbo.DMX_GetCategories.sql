SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetCategories]
 @PortalId INT,
 @EntryId INT,
 @Locale NVARCHAR(6)
AS
SELECT
 c.CategoryId, c.ParentId, c.PortalId, c.ViewOrder,
 ISNULL(cl.[CategoryName], c.CategoryName) CategoryName,
 (SELECT COUNT(*) FROM dbo.DMX_EntryCategories ec WHERE ec.EntryId=@EntryId  AND ec.CategoryId=c.CategoryId) Selected
FROM dbo.DMX_Categories c
 LEFT JOIN dbo.DMX_EntryCategories ec ON c.CategoryId=ec.CategoryId AND ec.EntryId=@EntryId
 LEFT JOIN dbo.DMX_CategoriesML cl ON c.CategoryId=cl.CategoryId AND cl.Locale=@Locale
WHERE c.PortalId=@PortalID
ORDER BY ParentId, ViewOrder
GO
