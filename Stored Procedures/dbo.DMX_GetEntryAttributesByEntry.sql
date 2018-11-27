SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetEntryAttributesByEntry]
 @EntryId INT,
 @Locale NVARCHAR(10)
AS
SELECT
 ea.[EntryId],
 ea.[Value],
 a.Addon, a.AttributeId, a.ControlToLoad, a.IsPrivate, a.[Key], a.PortalId, a.Required,
 a.ResourceFile, a.[Values], a.ValueType, a.ViewOrder, a.CollectionId, a.ShowInUI,
 ISNULL(al.AttributeName, a.AttributeName) AttributeName
FROM
 dbo.DMX_EntryAttributes ea
 INNER JOIN dbo.DMX_Attributes a ON ea.AttributeId=a.AttributeId
  LEFT JOIN dbo.DMX_AttributesML al ON al.AttributeId=a.AttributeId AND al.Locale=@Locale
WHERE
 ea.EntryId = @EntryId
GO
