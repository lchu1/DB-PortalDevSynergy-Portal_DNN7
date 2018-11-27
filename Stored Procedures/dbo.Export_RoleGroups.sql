SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_RoleGroups]
	@PortalID  int,
	@ToDate  datetime,
	@FromDate datetime=NULL
AS
BEGIN
	DECLARE @Now datetime = GETDATE()

	SELECT DISTINCT
		rg.*, u1.Username AS CreatedByUserName, u2.Username AS LastModifiedByUserName
	FROM
		dbo.RoleGroups AS rg
			LEFT OUTER JOIN dbo.Roles AS ro ON rg.RoleGroupID = ro.RoleGroupID
			LEFT OUTER JOIN dbo.Users AS u1 ON rg.CreatedByUserID = u1.UserID
			LEFT OUTER JOIN dbo.Users AS u2 ON rg.LastModifiedByUserID = u2.UserID
	WHERE
		rg.PortalID = @PortalID
	AND (
			( (COALESCE(rg.LastModifiedOnDate, rg.CreatedOnDate, @Now) <= @ToDate) AND ((@FromDate IS NULL OR ISNULL(rg.LastModifiedOnDate, rg.CreatedOnDate) >= @FromDate)))
		OR
			( (COALESCE(ro.LastModifiedOnDate, ro.CreatedOnDate, @Now) <= @ToDate) AND ((@FromDate IS NULL OR ISNULL(ro.LastModifiedOnDate, ro.CreatedOnDate) >= @FromDate)))
		)
END
GO
