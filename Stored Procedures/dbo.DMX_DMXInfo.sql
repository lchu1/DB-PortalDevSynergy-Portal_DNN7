SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DMXInfo]
AS
SELECT 
 p.PortalId, 
 (SELECT COUNT(*) FROM dbo.DMX_Extensions ext WHERE ext.PortalId=p.PortalId) NrExtensions,
 (SELECT COUNT(*) FROM dbo.DMX_Permissions pe WHERE pe.PortalId=p.PortalId) NrPermissions,
 (SELECT COUNT(*) FROM dbo.DMX_PermissionPermissions pp 
      INNER JOIN dbo.DMX_Permissions ppe ON pp.PermissionId=ppe.PermissionId WHERE ppe.PortalId=p.PortalId) NrPermissionPermissions,
 (SELECT COUNT(*) FROM dbo.DMX_LogTypes lt WHERE lt.PortalId=p.PortalId) NrLogTypes,
 (SELECT COUNT(*) FROM dbo.DMX_Entries e WHERE e.PortalId=p.PortalId) NrEntries,
 (SELECT COUNT(*) FROM dbo.DMX_Attributes a WHERE a.PortalId=p.PortalId) NrAttributes,
 (SELECT COUNT(*) FROM dbo.DMX_Categories c WHERE c.PortalId=p.PortalId) NrCategories,
 (SELECT COUNT(e.EntryId) FROM dbo.DMX_Entries e
   INNER JOIN dbo.DMX_EntryPermissions ep ON e.EntryID=ep.EntryId
   INNER JOIN dbo.DMX_Permissions p ON p.PermissionId=ep.PermissionId
  WHERE p.PermissionKey='APPROVE' AND e.PortalId=p.PortalId) NrApprovalItems
FROM dbo.Portals p
GO
