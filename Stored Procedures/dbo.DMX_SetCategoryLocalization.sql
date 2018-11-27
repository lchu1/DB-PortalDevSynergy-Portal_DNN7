SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_SetCategoryLocalization]
 @CategoryId INT,
 @Locale VARCHAR(10),
 @CategoryName NVARCHAR(200)
AS
IF @CategoryName=''
 DELETE FROM dbo.DMX_CategoriesML
 WHERE [CategoryId] = @CategoryId AND [Locale] = @Locale
ELSE BEGIN
 IF EXISTS (SELECT CategoryName FROM dbo.DMX_CategoriesML WHERE [CategoryId] = @CategoryId AND [Locale] = @Locale)
  UPDATE dbo.DMX_CategoriesML
   SET [CategoryName] = @CategoryName
   WHERE [CategoryId] = @CategoryId AND [Locale] = @Locale
 ELSE
  INSERT INTO dbo.DMX_CategoriesML
   ([CategoryId], [Locale], [CategoryName])
   VALUES (@CategoryId, @Locale, @CategoryName)
END
GO
