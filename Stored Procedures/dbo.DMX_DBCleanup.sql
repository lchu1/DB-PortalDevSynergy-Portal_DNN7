SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DBCleanup]
AS
DELETE FROM dbo.DMX_Permissions
FROM dbo.DMX_Permissions perm
 LEFT JOIN dbo.Portals p ON perm.PortalId=p.PortalId
WHERE perm.PortalId>-1
 AND p.PortalId IS NULL;
DELETE FROM dbo.DMX_Extensions
FROM dbo.DMX_Extensions ext
 LEFT JOIN dbo.Portals p ON ext.PortalId=p.PortalId
WHERE ext.PortalId>-1
 AND p.PortalId IS NULL;
GO
