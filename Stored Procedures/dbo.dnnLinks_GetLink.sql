SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[dnnLinks_GetLink]

@ItemId   int,
@ModuleId int

AS

SELECT  L.ItemId,
	L.ModuleId,
	L.Title,
	L.URL,
    L.ViewOrder,
    L.Description,
    L.CreatedByUser,
    L.CreatedDate,
    UT.TrackClicks,
    UT.NewWindow,
    L.RefreshInterval,
    L.GrantRoles
FROM    dbo.Links L
LEFT OUTER JOIN dbo.UrlTracking UT ON L.URL = UT.Url AND L.ModuleId = UT.ModuleId 
WHERE  L.ItemId = @ItemId AND L.ModuleId = @ModuleId
GO
