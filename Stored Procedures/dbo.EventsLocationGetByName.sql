SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[EventsLocationGetByName]
(
	@LocationName nvarchar(50)
,	@PortalID int
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
WHERE	LocationName = @LocationName
	AND	PortalID = @PortalID
GO
