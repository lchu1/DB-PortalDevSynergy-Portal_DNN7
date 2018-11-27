SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeleteCategory]
 @CategoryId INT
AS
DELETE FROM dbo.DMX_EntryCategories
WHERE CategoryId=@CategoryId;
DELETE FROM dbo.DMX_Categories
WHERE CategoryId=@CategoryId;
GO
