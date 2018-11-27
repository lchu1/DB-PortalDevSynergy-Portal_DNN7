SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetPortalAttributeListWithEntryData]
 @PortalId INT,
 @EntryId INT,
 @EntryType NVARCHAR(50),
 @IncludePrivate BIT,
 @Locale NVARCHAR(10)
AS
SELECT
 ea.[EntryId], 
 ea.[Value],
 a.Addon, a.AttributeId, a.ControlToLoad, a.IsPrivate, a.[Key], a.PortalId, a.Required,
 a.ResourceFile, a.[Values], a.ValueType, a.ViewOrder, a.CollectionId, a.ShowInUI,
 ISNULL(al.AttributeName, a.AttributeName) AttributeName,
 CAST ((CASE WHEN (NOT EXISTS(SELECT * FROM dbo.DMX_AttributeEntrytypes WHERE AttributeId=a.AttributeId)
   OR EXISTS(SELECT * FROM dbo.DMX_AttributeEntrytypes WHERE AttributeId=a.AttributeId AND @EntryType LIKE EntryType+'%')) THEN 1 ELSE 0 END) AS BIT) AS Applies
 FROM dbo.DMX_Attributes a
  LEFT JOIN (SELECT * FROM dbo.DMX_EntryAttributes WHERE EntryId = @EntryId) ea ON ea.AttributeId=a.AttributeId
  LEFT JOIN dbo.DMX_AttributesML al ON al.AttributeId=a.AttributeId AND al.Locale=@Locale
  WHERE a.PortalId=@PortalId
  AND (a.IsPrivate=0 OR @IncludePrivate=1)
GO
