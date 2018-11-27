SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetSearchModules]
	@PortalID int
AS
BEGIN	
	DECLARE @currentDate AS [DATETIME] = GETDATE();

	SELECT *
	FROM dbo.vw_Modules
	WHERE IsDeleted = 0  
	  AND IsTabDeleted = 0  
	  AND IsAdmin = 0
	  AND (SupportedFeatures & 2) = 2
	  AND (StartDate <= @currentDate OR StartDate IS NULL) 
	  AND (EndDate > @currentDate OR EndDate IS NULL) 
	  AND (TabEndDate > @currentDate OR TabEndDate IS NULL) 
	  AND (TabStartDate <= @currentDate OR TabStartDate IS NULL) 
	  AND (NOT (BusinessControllerClass IS NULL))
	  AND (PortalID = @PortalID OR (PortalID IS NULL AND @PortalID Is NULL))
	ORDER BY ModuleOrder
END
GO
