SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[EventsLocationSave]
(
	@PortalID int,
	@Location int,
	@LocationName nvarchar(50),
	@MapURL nvarchar(255),
	@Street nvarchar(50),
	@PostalCode nvarchar(50),
	@City nvarchar(50),
	@Region nvarchar(50),
	@Country nvarchar(50)

)
AS
IF @Location = 0 OR @Location IS NULL
	INSERT dbo.[EventsLocation]
	(
		PortalID,
		LocationName,
		MapURL,
		Street,
		PostalCode,
		City,
		Region,
		Country
	)
	VALUES
	(
		@PortalID,
		@LocationName,
		@MapURL,
		@Street,
		@PostalCode,
		@City,
		@Region,
		@Country
	)
ELSE
	UPDATE dbo.[EventsLocation] SET
		LocationName = @LocationName,
		MapURL = @MapURL,
		Street = @Street,
		PostalCode = @PostalCode,
		City = @City,
		Region = @Region,
		Country = @Country
	WHERE	Location = @Location
		AND	PortalID = @PortalID

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
WHERE	Location = scope_identity()
GO
