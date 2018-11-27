SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_ResortCategories]
 @PortalId INT,
 @ParentId INT
AS
UPDATE dbo.DMX_Categories
 SET ViewOrder = subcats.vo
FROM dbo.DMX_Categories c
 INNER JOIN (SELECT
  CategoryId,
  ROW_NUMBER() OVER(ORDER BY ViewOrder ASC) - 1 vo
  FROM dbo.DMX_Categories
  WHERE PortalId=@PortalId AND ParentId=@ParentId) subcats ON subcats.CategoryId=c.CategoryId
GO
