SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetAttributeListForEntry]
 @PortalId INT,
 @CollectionId INT,
 @EntryId INT,
 @EntryType NVARCHAR(50),
 @IncludePrivate BIT,
 @Locale NVARCHAR(10)
AS
WITH tmp (EntryId, CollectionId) AS
 (SELECT e1.EntryId, e1.CollectionId FROM dbo.DMX_Entries e1 WHERE e1.EntryId=@CollectionId AND e1.InheritAttributes=1
  UNION ALL
  SELECT e.EntryId, e.CollectionId FROM dbo.DMX_Entries e
   INNER JOIN tmp ON e.EntryId=tmp.CollectionId WHERE e.InheritAttributes=1)
SELECT
 ea.[EntryId], 
 ea.[Value],
 a.Addon, a.AttributeId, a.ControlToLoad, a.IsPrivate, a.[Key], a.PortalId, a.Required,
 a.ResourceFile, a.[Values], a.ValueType, a.ViewOrder, a.CollectionId, a.ShowInUI,
 ISNULL(al.AttributeName, a.AttributeName) AttributeName,
 CAST ((CASE WHEN (NOT EXISTS(SELECT * FROM dbo.DMX_AttributeEntrytypes WHERE AttributeId=a.AttributeId)
   OR EXISTS(SELECT * FROM dbo.DMX_AttributeEntrytypes WHERE AttributeId=a.AttributeId AND @EntryType LIKE EntryType+'%')) THEN 1 ELSE 0 END) AS BIT) AS Applies
 FROM dbo.DMX_Attributes a
  LEFT JOIN dbo.DMX_AttributesML al ON al.AttributeId=a.AttributeId AND al.Locale=@Locale
  LEFT JOIN (SELECT * FROM dbo.DMX_EntryAttributes WHERE EntryId = @EntryId) ea ON ea.AttributeId=a.AttributeId
  LEFT JOIN tmp ON tmp.CollectionId=a.CollectionId
WHERE a.PortalId=@PortalId
 AND (a.IsPrivate=0 OR @IncludePrivate=1)
 AND (a.CollectionId=-1 OR (NOT tmp.CollectionId IS NULL) OR a.CollectionId=@CollectionId)
ORDER BY CASE a.CollectionId WHEN -1 THEN 0 ELSE 1 END, a.ViewOrder
GO
