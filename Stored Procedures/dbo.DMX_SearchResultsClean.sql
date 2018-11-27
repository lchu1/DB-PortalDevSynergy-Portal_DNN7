SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_SearchResultsClean]
 @SearchId NVARCHAR(50)
AS

RETRY:
BEGIN TRANSACTION
BEGIN TRY
 DECLARE @TMP TABLE (EntryId INT, [Rank] REAL, Hits INT, Extract NVARCHAR(2000));
 INSERT INTO @TMP (EntryId, [Rank], Hits, Extract)
 SELECT EntryId, SUM([Rank]), COUNT(Hits), dbo.DMX_ExtractConcatenate(EntryId, '&lt;br /&gt;')
 FROM dbo.DMX_SearchResults
 GROUP BY SearchId, EntryId
 HAVING SearchId=@SearchId OR SearchId LIKE @SearchId + '-%';
 
 DECLARE @maxRank REAL;
 SET @maxRank = (SELECT MAX([Rank]) FROM @TMP);
 IF @maxRank=0
  SET @maxRank=1;

 UPDATE @TMP
 SET [Rank] = [Rank]/@maxRank*1000;

 DELETE FROM dbo.DMX_SearchResults
 WHERE SearchId=@SearchId;

 INSERT INTO dbo.DMX_SearchResults
  (SearchId, EntryId, [Rank], Hits, Extract)
 SELECT
  @SearchId, EntryId, [Rank], Hits, Extract
 FROM @TMP;

 DELETE FROM dbo.DMX_SearchResults
 WHERE SearchId LIKE @SearchId + '-%';

 COMMIT TRANSACTION
END TRY
BEGIN CATCH
 ROLLBACK TRANSACTION
 IF ERROR_NUMBER() = 1205 -- Deadlock
 BEGIN
  WAITFOR DELAY '00:00:00.05'
  GOTO RETRY
 END
END CATCH
GO
