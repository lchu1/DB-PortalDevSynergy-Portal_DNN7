SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetDirectAccessKeysByEntry]
 @EntryId INT,
 @StartRowIndex INT = -1,
 @MaximumRows INT = 0,
 @OrderBy VARCHAR(100) = ''
AS
SELECT * FROM
(SELECT
 dak.*,
 ROW_NUMBER() OVER
 (ORDER BY
  CASE @OrderBy WHEN 'PORTALID DESC' THEN dak.[PortalId] END DESC,
  CASE @OrderBy WHEN 'PORTALID' THEN dak.[PortalId] END ASC,
  CASE @OrderBy WHEN 'PORTALID ASC' THEN dak.[PortalId] END ASC,
  CASE @OrderBy WHEN 'DOWNLOADS DESC' THEN dak.[Downloads] END DESC,
  CASE @OrderBy WHEN 'DOWNLOADS' THEN dak.[Downloads] END ASC,
  CASE @OrderBy WHEN 'DOWNLOADS ASC' THEN dak.[Downloads] END ASC,
  CASE @OrderBy WHEN 'EMAIL DESC' THEN dak.[Email] END DESC,
  CASE @OrderBy WHEN 'EMAIL' THEN dak.[Email] END ASC,
  CASE @OrderBy WHEN 'EMAIL ASC' THEN dak.[Email] END ASC,
  CASE @OrderBy WHEN 'ENTRYID DESC' THEN dak.[EntryId] END DESC,
  CASE @OrderBy WHEN 'ENTRYID' THEN dak.[EntryId] END ASC,
  CASE @OrderBy WHEN 'ENTRYID ASC' THEN dak.[EntryId] END ASC,
  CASE @OrderBy WHEN 'EXPIRES DESC' THEN dak.[Expires] END DESC,
  CASE @OrderBy WHEN 'EXPIRES' THEN dak.[Expires] END ASC,
  CASE @OrderBy WHEN 'EXPIRES ASC' THEN dak.[Expires] END ASC,
  CASE @OrderBy WHEN 'KEY DESC' THEN dak.[Key] END DESC,
  CASE @OrderBy WHEN 'KEY' THEN dak.[Key] END ASC,
  CASE @OrderBy WHEN 'KEY ASC' THEN dak.[Key] END ASC,
  CASE @OrderBy WHEN 'USERID DESC' THEN dak.[UserId] END DESC,
  CASE @OrderBy WHEN 'USERID' THEN dak.[UserId] END ASC,
  CASE @OrderBy WHEN 'USERID ASC' THEN dak.[UserId] END ASC
) AS RowNum
FROM
 dbo.DMX_DirectAccessKeys dak
WHERE
 dak.EntryId = @EntryId) AS Tbl
WHERE ((RowNum BETWEEN @StartRowIndex AND (@MaximumRows + @StartRowIndex - 1)) OR @StartRowIndex = 0)
 OR (@StartRowIndex = -1 AND (RowNum-1) % @MaximumRows = 0)
ORDER BY RowNum ASC
GO
