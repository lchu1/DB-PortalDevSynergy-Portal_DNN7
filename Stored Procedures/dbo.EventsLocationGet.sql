SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[EventsLocationGet]
(
	@Location int,
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
WHERE	Location = @Location
	AND	PortalID = @PortalID
GO
