SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetEntryCategoriesByCategory]
 @CategoryId Int
AS
SELECT
 *
FROM
 dbo.DMX_EntryCategories
WHERE
 CategoryId = @CategoryId
GO
