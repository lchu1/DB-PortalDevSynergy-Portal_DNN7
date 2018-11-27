SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_GetPortalLanguages]
	@PortalID	int,
	@ToDate   datetime,
	@FromDate	datetime=NULL
AS
	SELECT	PL.*,dbo.[Export_UserName](PL.CreatedByUserId) CreatedByUserName,dbo.[Export_UserName](PL.LastModifiedByUserId) LastModifiedByUserName, L.[CultureCode]
	FROM
		dbo.[PortalLanguages] PL
	INNER JOIN dbo.[Languages] L ON PL.[LanguageID]=L.[LanguageID]
	WHERE  PortalId = @PortalID
	AND
			(CASE
			WHEN @FromDate IS NULL THEN 0
			WHEN PL.LastModifiedOnDate IS NULL THEN PL.CreatedOnDate
			ELSE PL.LastModifiedOnDate END)>= ISNULL(@FromDate,0)
	AND (CASE
			WHEN PL.LastModifiedOnDate IS NULL THEN PL.CreatedOnDate
			ELSE PL.LastModifiedOnDate END)<= @ToDate
GO
