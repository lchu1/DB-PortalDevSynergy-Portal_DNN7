SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_LimitSearch]
 @PortalId Int,
 @SearchId nvarchar(50),
 @CollectionId Int,
 @CategoryId INT,
 @OnlyLastVersion BIT,
 @HideDeleted BIT,
 @OnlyApproved BIT,
 @NrHits INT,
 @MaxSearchResults INT
AS
BEGIN
 IF @CollectionId > -1
 BEGIN
  DECLARE @entrypath VARCHAR(4000)
  SET @entrypath = (SELECT [Path] 
   FROM dbo.DMX_Entries
   WHERE EntryId = @CollectionId);
  DELETE FROM dbo.DMX_SearchResults
   FROM dbo.DMX_SearchResults sr
   INNER JOIN dbo.DMX_Entries e ON sr.EntryId=e.EntryId
   WHERE NOT e.[Path] LIKE @entrypath+'%';
 END
 IF @OnlyLastVersion = 1
 BEGIN
  DELETE FROM dbo.DMX_SearchResults
   FROM dbo.DMX_SearchResults sr
   INNER JOIN dbo.DMX_Entries e ON sr.EntryId=e.EntryId
   WHERE NOT e.LastVersionId = e.EntryId;
 END
 IF @HideDeleted = 1
 BEGIN
  DELETE FROM dbo.DMX_SearchResults
   FROM dbo.DMX_SearchResults sr
   INNER JOIN dbo.DMX_Entries e ON sr.EntryId=e.EntryId
   WHERE e.Deleted = 1;
 END
 IF @OnlyApproved = 1
 BEGIN
  DELETE FROM dbo.DMX_SearchResults
   FROM dbo.DMX_SearchResults sr
   INNER JOIN dbo.DMX_Entries e ON sr.EntryId=e.EntryId
   WHERE e.IsApproved = 0;
 END
 IF @NrHits > 1
 BEGIN
  DELETE FROM dbo.DMX_SearchResults
  WHERE SearchId=@SearchId
   AND Hits < @NrHits;
 END
 IF @CategoryId > -1
 BEGIN
  DELETE FROM dbo.DMX_SearchResults
  FROM dbo.DMX_SearchResults sr
   LEFT JOIN dbo.DMX_EntryCategories ec ON ec.EntryId=sr.EntryId AND ec.CategoryId=@CategoryId
  WHERE ec.EntryId IS NULL
 END
 IF @MaxSearchResults > -1
 BEGIN
  DELETE FROM dbo.DMX_SearchResults
  FROM dbo.DMX_SearchResults sr
   INNER JOIN (SELECT *, ROW_NUMBER() OVER (ORDER BY Hits DESC) y
        FROM dbo.DMX_SearchResults) x ON x.SearchId=sr.SearchId AND x.EntryId=sr.EntryId
  WHERE x.y > @MaxSearchResults
 END
END
GO
