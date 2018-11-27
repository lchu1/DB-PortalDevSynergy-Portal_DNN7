SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeleteEntryCategory]
 @EntryId Int,
 @CategoryId Int
AS
DELETE FROM dbo.DMX_EntryCategories
WHERE
 [EntryId] = @EntryId
 AND [CategoryId] = @CategoryId
GO
