SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetEntryCategory]
 @EntryId Int,
 @CategoryId Int
AS
SELECT
 *
FROM
 dbo.DMX_EntryCategories
WHERE
 [EntryId] = @EntryId
 AND [CategoryId] = @CategoryId
GO
