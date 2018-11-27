SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetEntryAttributesByKeyAndValue]
 @PortalId INT,
 @Key NVARCHAR(50),
 @AttributeValue NVARCHAR(2000),
 @Locale NVARCHAR(10)
AS
SELECT
 ea.[EntryId], 
 ea.[Value],
 a.Addon, a.AttributeId, a.ControlToLoad, a.IsPrivate, a.[Key], a.PortalId, a.Required,
 a.ResourceFile, a.[Values], a.ValueType, a.ViewOrder, a.CollectionId, a.ShowInUI,
 ISNULL(al.AttributeName, a.AttributeName) AttributeName
FROM dbo.DMX_Attributes a
  LEFT JOIN dbo.DMX_AttributesML al ON al.AttributeId=a.AttributeId AND al.Locale=@Locale
 INNER JOIN dbo.DMX_EntryAttributes ea ON ea.AttributeId=a.AttributeId
 WHERE a.PortalId=@PortalID
  AND a.[Key]=@Key
  AND ea.Value=@AttributeValue
GO
