SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_GetPortalSettings]
	@PortalID	int,
	@ToDate   datetime,
	@FromDate	datetime=NULL
AS
	SELECT	*,dbo.[Export_UserName](CreatedByUserId) CreatedByUserName,dbo.[Export_UserName](LastModifiedByUserId) LastModifiedByUserName
	FROM
		dbo.[PortalSettings]
	WHERE  PortalId = @PortalID
	AND
		(CASE
		WHEN @FromDate IS NULL THEN 0
		WHEN LastModifiedOnDate IS NULL THEN CreatedOnDate
		ELSE ISNULL(LastModifiedOnDate,0) END)>= ISNULL(@FromDate,0)
	AND (CASE
			WHEN LastModifiedOnDate IS NULL THEN CreatedOnDate
			ELSE LastModifiedOnDate END)<= @ToDate
GO
