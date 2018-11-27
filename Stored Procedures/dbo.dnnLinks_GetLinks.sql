SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[dnnLinks_GetLinks]

@ModuleId int

AS

SELECT L.ItemId,
       L.ModuleId,
       L.CreatedByUser,
       L.CreatedDate,
       L.Title,
       L.URL,
       L.ViewOrder,
       L.Description,
       UT.TrackClicks,
       UT.NewWindow,
       L.RefreshInterval,
       L.GrantRoles
FROM   dbo.Links L
LEFT OUTER JOIN dbo.UrlTracking UT ON L.URL = UT.Url AND L.ModuleId = UT.ModuleId 
WHERE  L.ModuleId = @ModuleId 
ORDER BY L.ViewOrder, L.Title
GO
