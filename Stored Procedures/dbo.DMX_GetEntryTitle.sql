SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetEntryTitle]
 @PortalId INT,
 @EntryId INT,
 @Locale VARCHAR(10)
AS
SELECT ISNULL(el.Title, e.Title) Title
 FROM dbo.DMX_Entries e
  LEFT JOIN dbo.DMX_EntriesML el ON e.EntryId=el.EntryId AND el.Locale=@Locale
 WHERE e.EntryID=@EntryId
 AND e.PortalID=@PortalId
 AND (e.Version=(SELECT MAX(Version) FROM dbo.DMX_Entries e2 WHERE e2.LastVersionId=e.LastVersionId AND e2.IsApproved=1))
GO
