SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[Export_GetActiveTabModules]
(
	@TabID int
)
RETURNS @ModuleIds TABLE
(
	ModuleId INT
)
AS
BEGIN 
	DECLARE @StateId int;
	SELECT @StateId=StateID FROM  dbo.[ContentItems] WHERE TabID=@TabID AND ModuleID=-1;
	--IF there is versioninig with the tab
	IF(@StateId IS NOT NULL)
	BEGIN
		-- Get all distinct module ids which belong to any published version of the tab
		INSERT INTO @ModuleIds (ModuleId)
		SELECT DISTINCT TM.ModuleId From dbo.[TabModules] TM
		LEFT JOIN dbo.[TabVersions] TV ON TM.TabID=TV.TabId
		LEFT JOIN dbo.[TabVersionDetails] TVD ON TV.TabVersionId=TVD.TabVersionId 
		WHERE TM.TabId=@TabID AND (TV.IsPublished=1 OR TV.IsPublished IS NULL)

		--Delete modules which have been deleted from page

		--DELETE FROM @ModuleIds 
		--WHERE ModuleId IN(
		--SELECT DISTINCT TVD.ModuleId FROM  dbo.[TabVersionDetails] TVD 
		--INNER JOIN dbo.[TabVersions] TV ON TV.TabVersionId=TVD.TabVersionId
		--WHERE TV.TabId=@TabID AND TV.IsPublished=1 and Action=2)
	END
	ELSE
	BEGIN
		INSERT INTO @ModuleIds (ModuleId) SELECT DISTINCT ModuleId FROM dbo.[TabModules] WHERE TabID=@TabID
	END
	RETURN;
END
GO
