SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetAttributesByEntryType]
 @PortalId INT,
 @EntryType NVARCHAR(50),
 @Locale NVARCHAR(10)
AS
SELECT 
 a.Addon, a.AttributeId, a.ControlToLoad, a.IsPrivate, a.[Key], a.PortalId, a.Required,
 a.ResourceFile, a.[Values], a.ValueType, a.ViewOrder, a.CollectionId, a.ShowInUI,
 ISNULL(al.AttributeName, a.AttributeName) AttributeName
FROM dbo.DMX_Attributes a
  LEFT JOIN dbo.DMX_AttributesML al ON al.AttributeId=a.AttributeId AND al.Locale=@Locale
 WHERE a.PortalId=@PortalId
 AND a.IsPrivate=0
 AND (NOT EXISTS(SELECT * FROM dbo.DMX_AttributeEntrytypes WHERE AttributeId=a.AttributeId)
  OR EXISTS(SELECT * FROM dbo.DMX_AttributeEntrytypes WHERE AttributeId=a.AttributeId AND @EntryType LIKE EntryType+'%'))
GO
