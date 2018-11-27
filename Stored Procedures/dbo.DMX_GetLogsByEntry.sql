SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetLogsByEntry]
 @EntryId INT,
 @MaxRecords INT
AS
IF @MaxRecords > 0
 BEGIN
  DECLARE @SQL varchar(max);
  SET @SQL = 'SELECT TOP ' + Convert(varchar, @MaxRecords);
  SET @SQL = @SQL + ' *';
  SET @SQL = @SQL + ' FROM dbo.vw_DMX_Log';
  SET @SQL = @SQL + ' WHERE EntryId = ' + Convert(varchar, @EntryId) + ' ORDER BY Datime DESC';
  EXEC(@SQL);
 END
ELSE
 SELECT
  *
 FROM
  dbo.vw_DMX_Log
 WHERE
  EntryId = @EntryId
  ORDER BY Datime DESC;
GO
