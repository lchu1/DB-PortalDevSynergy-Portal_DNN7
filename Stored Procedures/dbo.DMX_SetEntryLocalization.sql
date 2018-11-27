SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_SetEntryLocalization]
 @EntryId INT,
 @Locale VARCHAR(10),
 @Title NVARCHAR(1000),
 @Remarks NVARCHAR(MAX)
AS
IF @Title='' AND (@Remarks IS NULL OR @REMARKS = '')
 DELETE FROM dbo.DMX_EntriesML
 WHERE [EntryId] = @EntryId AND [Locale] = @Locale
ELSE BEGIN
 IF EXISTS (SELECT EntryId FROM dbo.DMX_EntriesML WHERE [EntryId] = @EntryId AND [Locale] = @Locale)
  UPDATE dbo.DMX_EntriesML
   SET [Title] = @Title, [Remarks] = @Remarks
   WHERE [EntryId] = @EntryId AND [Locale] = @Locale
 ELSE
  INSERT INTO dbo.DMX_EntriesML
   ([EntryId], [Locale], [Title], [Remarks])
   VALUES (@EntryId, @Locale, @Title, @Remarks)
END
GO
