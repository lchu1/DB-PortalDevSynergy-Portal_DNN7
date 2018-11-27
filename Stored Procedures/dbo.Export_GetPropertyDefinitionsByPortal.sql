SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_GetPropertyDefinitionsByPortal]
	@PortalID	int,
	@IncludeDeleted bit = 0,
	@ToDate datetime,
	@FromDate	datetime=NULL
AS
	SELECT	*
	FROM	dbo.[ProfilePropertyDefinition] PPD
	WHERE  (PortalId = @PortalID OR (PortalId IS NULL AND @PortalID IS NULL))
	AND PPD.Deleted <= CASE @IncludeDeleted WHEN 0 THEN 0 ELSE 1 END
	AND
		(CASE
		WHEN @FromDate IS NULL THEN 0
		WHEN PPD.LastModifiedOnDate IS NULL THEN PPD.CreatedOnDate
		ELSE PPD.LastModifiedOnDate END)>= ISNULL(@FromDate,0)
	AND (CASE
		WHEN PPD.LastModifiedOnDate IS NULL THEN PPD.CreatedOnDate
		ELSE PPD.LastModifiedOnDate END)<= @ToDate
	ORDER BY ViewOrder
GO
