SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_ContentWorkflows]
	@PortalID       int,
	@IncludeDeleted bit
AS
BEGIN
	SELECT
		*
	FROM
		dbo.ContentWorkflows
	WHERE
		PortalID = @PortalID
	  AND
		(@IncludeDeleted = 1 OR IsDeleted = 0)
END
GO
