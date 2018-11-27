SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_RenameEntry]
 @PortalId INT,
 @EntryId INT,
 @Locale NVARCHAR(10),
 @NewName NVARCHAR(1000)
AS
 IF EXISTS(SELECT EntryId FROM dbo.DMX_Entries WHERE EntryId=@EntryId AND PortalId=@PortalId)
  BEGIN
   IF @Locale=''
    UPDATE dbo.DMX_Entries
     SET Title=@NewName WHERE EntryId=@EntryId AND PortalId=@PortalId
   ELSE BEGIN
    IF EXISTS (SELECT EntryId FROM dbo.DMX_EntriesML WHERE [EntryId] = @EntryId AND [Locale] = @Locale)
     UPDATE dbo.DMX_EntriesML
     SET [Title] = @NewName
     WHERE [EntryId] = @EntryId AND [Locale] = @Locale
    ELSE
     INSERT INTO dbo.DMX_EntriesML
      ([EntryId], [Locale], [Title])
      VALUES (@EntryId, @Locale, @NewName)
   END
  END
GO
