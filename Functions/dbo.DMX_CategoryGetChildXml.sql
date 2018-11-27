SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[DMX_CategoryGetChildXml]
 (@PortalId INT, @ParentId INT, @Locale NVARCHAR(10))
RETURNS XML
BEGIN
 RETURN (
  SELECT
   c.CategoryId AS '@Id',
   ISNULL(cml.CategoryName, c.CategoryName) AS '@Name',
   dbo.DMX_CategoryGetChildXml(@PortalId, c.CategoryId, @Locale)
  FROM dbo.DMX_Categories c
   LEFT JOIN dbo.DMX_CategoriesML cml ON cml.CategoryId=c.CategoryId AND cml.Locale=@Locale
  WHERE c.ParentId=@ParentId AND c.PortalId=@PortalId
  FOR XML PATH('category'), TYPE, ROOT('categories')
 )
END
GO
