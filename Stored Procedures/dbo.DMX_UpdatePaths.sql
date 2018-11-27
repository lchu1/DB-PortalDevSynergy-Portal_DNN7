SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UpdatePaths]
 @PortalID INT,
 @EntryId INT = NULL
AS
BEGIN
-- NULLIFY what is 'dirty' 
IF @EntryId is NULL 
 BEGIN
  UPDATE dbo.DMX_Entries SET [Path]=NULL WHERE PortalID = @PortalID;
 END 
ELSE 
 BEGIN
  DECLARE @OldPath VARCHAR(4000)
  SELECT @OldPath = (SELECT [Path] FROM dbo.DMX_Entries WHERE EntryId=@EntryId)
  UPDATE dbo.DMX_Entries 
   SET [Path]=NULL 
  WHERE [Path] LIKE @OldPath + '%' 
   AND PortalID = @PortalID 
 END
-- If we have any root items with NULL we set the [Path] for these 
UPDATE dbo.DMX_Entries 
 SET [Path] = '0;' + Cast(EntryId as NVARCHAR(32)) + ';' 
WHERE
 CollectionId=0
 And PortalId=@PortalId
 AND [Path] IS NULL
-- As long as we find items that are nullified but whose parents are not NULL, we set the path for them
WHILE EXISTS 
 (SELECT 'X' 
  FROM dbo.DMX_Entries 
  WHERE 
   PortalId=@PortalId
   AND [Path] IS NULL
   AND EXISTS (SELECT 'X' 
               FROM dbo.DMX_Entries e1 
               WHERE e1.[Path] IS NOT NULL 
                AND e1.EntryID=dbo.DMX_Entries.CollectionID))
 BEGIN
  UPDATE dbo.DMX_Entries
   SET [Path] = (SELECT e2.[Path] + CAST(dbo.DMX_Entries.EntryId AS NVARCHAR(32)) + ';' 
                 FROM dbo.DMX_Entries e2 
                 WHERE e2.EntryID=dbo.DMX_Entries.CollectionID)
  WHERE 
   dbo.DMX_Entries.PortalId=@PortalId
   AND [Path] IS NULL
   AND EXISTS (SELECT 'X' 
               FROM dbo.DMX_Entries e3 
               WHERE e3.[Path] IS NOT NULL 
                AND e3.EntryID=dbo.DMX_Entries.CollectionID)
 END;
END
GO
