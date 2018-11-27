SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetPortalDetails]
AS
SELECT 
 p.*, 
 (SELECT COUNT(*) FROM Users u INNER JOIN UserPortals up ON u.UserId=up.UserId WHERE up.PortalId=p.PortalId) AS NrUsers, 
 (SELECT COUNT(*) FROM Tabs t WHERE t.PortalID=p.PortalID) AS NrTabs 
FROM Portals p
 ORDER BY p.PortalId
GO
