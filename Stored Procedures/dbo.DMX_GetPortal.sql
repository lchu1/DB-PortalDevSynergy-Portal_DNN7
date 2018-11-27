SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetPortal]
 @PortalId INT,
 @Locale NVARCHAR(6)
AS
DECLARE @DNNVersion INT
SET @DNNVersion = (SELECT MAX(v) FROM
(SELECT Major * 10000 + Minor * 100 + Build AS v FROM dbo.Version) AS x)
IF @DNNVersion > 50200
 BEGIN
  IF EXISTS(SELECT * FROM dbo.PortalLocalization WHERE PortalId=@PortalId AND CultureCode=@Locale)
  SELECT * FROM dbo.Portals p
   INNER JOIN dbo.PortalLocalization pl ON p.PortalId=pl.PortalId
   WHERE p.PortalId=@PortalId
   AND pl.CultureCode=@Locale
  ELSE
  SELECT * FROM dbo.Portals p
   INNER JOIN dbo.PortalLocalization pl ON p.PortalId=pl.PortalId
   WHERE p.PortalId=@PortalId
   AND pl.CultureCode=p.DefaultLanguage
 END
ELSE
 BEGIN
  SELECT * FROM dbo.Portals
   WHERE PortalId=@PortalId
 END
GO
