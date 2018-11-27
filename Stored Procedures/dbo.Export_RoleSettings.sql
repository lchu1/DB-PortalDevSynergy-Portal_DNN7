SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_RoleSettings]
	@PortalID  int,
	@ToDate  datetime,
	@FromDate datetime=NULL
AS
	SELECT
		rs.*, u1.Username AS CreatedByUserName, u2.Username AS LastModifiedByUserName
	FROM
		dbo.RoleSettings AS rs
			INNER JOIN dbo.Roles AS r on r.RoleID = rs.RoleID
			LEFT OUTER JOIN dbo.Users AS u1 ON rs.CreatedByUserID = u1.UserID
			LEFT OUTER JOIN dbo.Users AS u2 ON rs.LastModifiedByUserID = u2.UserID
	WHERE
		r.PortalID = @PortalID
	AND (CASE
		WHEN @FromDate IS NULL THEN 0
		WHEN rs.LastModifiedOnDate IS NULL THEN rs.CreatedOnDate
		ELSE rs.LastModifiedOnDate END)>= ISNULL(@FromDate,0)
	AND (CASE
			WHEN rs.LastModifiedOnDate IS NULL THEN rs.CreatedOnDate
			ELSE rs.LastModifiedOnDate END)<= @ToDate
GO
