SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetAttributesByAddon]
 @Addon NVARCHAR (50),
 @Locale NVARCHAR(10)
AS
SELECT
 a.Addon, a.AttributeId, a.ControlToLoad, a.IsPrivate, a.[Key], a.PortalId, a.Required,
 a.ResourceFile, a.[Values], a.ValueType, a.ViewOrder, a.CollectionId, a.ShowInUI,
 ISNULL(al.AttributeName, a.AttributeName) AttributeName
FROM
 dbo.DMX_Attributes a
  LEFT JOIN dbo.DMX_AttributesML al ON al.AttributeId=a.AttributeId AND al.Locale=@Locale
WHERE
 a.Addon = @Addon
GO
