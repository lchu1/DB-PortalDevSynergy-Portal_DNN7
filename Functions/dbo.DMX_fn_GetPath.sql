SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[DMX_fn_GetPath]
 (@EntryId INT, 
  @PortalId INT, 
  @Locale NVARCHAR(10))
RETURNS NVARCHAR(4000)
AS
BEGIN
 DECLARE @res NVARCHAR(4000)
 IF EXISTS (SELECT EntryId FROM dbo.DMX_Entries WHERE EntryId=@EntryId AND PortalId=@PortalId)
 BEGIN
  DECLARE 
   @collection INT,
   @name NVARCHAR(2000),
   @orig NVARCHAR(300);
  WITH x AS (
   SELECT e.CollectionId, e.OriginalFileName, ISNULL(el.Title, e.Title) Title
   FROM dbo.DMX_Entries e
    LEFT JOIN dbo.DMX_EntriesML el ON e.EntryId=el.EntryId AND el.Locale=@Locale
   WHERE e.EntryId=@EntryId AND e.PortalId=@PortalId)
  SELECT
   @collection = CollectionId,
   @name = Title,
   @orig = OriginalFilename
  FROM x;
  SELECT @res = dbo.DMX_fn_GetPath(@collection, @PortalId, @Locale)+'/'+@name+dbo.DMX_fn_GetExtension(@orig)
 END
ELSE
 SELECT @res = ''
RETURN @res
END
GO
