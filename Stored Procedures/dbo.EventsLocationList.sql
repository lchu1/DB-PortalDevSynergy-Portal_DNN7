SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[EventsLocationList]
(
	@PortalID int
)
AS
SELECT	Location
	,	PortalID
	,	LocationName
	,	MapURL
	,	Street
	,	PostalCode
	,	City
	,	Region
	,	Country
FROM	dbo.[EventsLocation]
WHERE	PortalID = @PortalID
ORDER BY	LocationName
GO
