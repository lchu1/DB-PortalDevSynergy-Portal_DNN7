SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetEntryCategoriesByEntry]
 @EntryId Int
AS
SELECT
 *
FROM
 dbo.DMX_EntryCategories
WHERE
 EntryId = @EntryId
GO
