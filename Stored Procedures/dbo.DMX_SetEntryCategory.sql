SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_SetEntryCategory]
 @EntryId INT, 
 @CategoryId INT
AS
IF NOT EXISTS
 (SELECT * FROM dbo.DMX_EntryCategories
  WHERE EntryId=@EntryId AND CategoryId=@CategoryId)
INSERT INTO dbo.DMX_EntryCategories (
 [EntryId],
 [CategoryId])
VALUES (
 @EntryId,
 @CategoryId)
GO
