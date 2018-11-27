SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddEntryCategory]
 @EntryId Int, 
 @CategoryId Int
AS
INSERT INTO dbo.DMX_EntryCategories (
 [EntryId],
 [CategoryId]
) VALUES (
 @EntryId,
 @CategoryId
)
GO
