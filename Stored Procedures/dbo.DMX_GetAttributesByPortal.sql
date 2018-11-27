SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetAttributesByPortal]
 @PortalId INT,
 @Locale NVARCHAR(10)
AS
SELECT
 a.Addon, a.AttributeId, a.ControlToLoad, a.IsPrivate, a.[Key], a.PortalId, a.Required,
 a.ResourceFile, a.[Values], a.ValueType, a.ViewOrder, a.CollectionId, a.ShowInUI,
 ISNULL(al.AttributeName, a.AttributeName) AttributeName,
 ad.Description AS AddonsDescription
FROM
 dbo.DMX_Addons ad 
 INNER JOIN dbo.DMX_Attributes a ON ad.AddonKey = a.Addon
  LEFT JOIN dbo.DMX_AttributesML al ON al.AttributeId=a.AttributeId AND al.Locale=@Locale
WHERE
 a.PortalId = @PortalId
GO
