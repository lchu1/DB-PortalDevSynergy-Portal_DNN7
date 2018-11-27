SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_Roles]
	@PortalID  int,
	@ToDate  datetime,
	@FromDate datetime=NULL
AS
	SELECT
		r.*, u1.Username AS CreatedByUserName, u2.Username AS LastModifiedByUserName
	FROM
		dbo.Roles AS r
			LEFT OUTER JOIN dbo.RoleGroups AS rg on r.RoleGroupID = rg.RoleGroupID
			LEFT OUTER JOIN dbo.Users AS u1 ON r.CreatedByUserID = u1.UserID
			LEFT OUTER JOIN dbo.Users AS u2 ON r.LastModifiedByUserID = u2.UserID
	WHERE
		r.PortalID = @PortalID
	AND (CASE
		WHEN @FromDate IS NULL THEN 0
		WHEN r.LastModifiedOnDate IS NULL THEN r.CreatedOnDate
		ELSE r.LastModifiedOnDate END)>= ISNULL(@FromDate,0)
	AND (CASE
			WHEN r.LastModifiedOnDate IS NULL THEN r.CreatedOnDate
			ELSE r.LastModifiedOnDate END)<= @ToDate
GO
