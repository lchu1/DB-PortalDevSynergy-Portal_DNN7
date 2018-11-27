SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetModulePackagesInUse]
	@PortalID INT,
	@ForHost BIT
AS
BEGIN
	-- Create a temp table to store the select results
	CREATE TABLE #TabsLatestPublished
	(
		IndexId int IDENTITY (0, 1) NOT NULL,
		TabId int,
		ModuleId int
	);

	WITH Temp AS ( 
        SELECT ROW_NUMBER() OVER (PARTITION BY TabId ORDER BY Version DESC) AS RowNumber, TabVersionId, TabId
        FROM dbo.TabVersions
		WHERE IsPublished = 1		
    )
	-- Insert into our temp table
	INSERT INTO #TabsLatestPublished (TabId, ModuleId)
	SELECT TLP.TabId, TVD.ModuleId 	
	FROM Temp TLP
	INNER JOIN dbo.TabVersionDetails TVD ON TLP.TabVersionId = TVD.TabVersionId 
	WHERE RowNumber = 1 AND TVD.Action <> 2

	IF (@ForHost = 1)
		-- Get in use for all host pages and portal pages
		SELECT AllPackages.*
		FROM dbo.Packages AS AllPackages
			INNER JOIN (
				SELECT DISTINCT P.PackageID
				FROM         dbo.Packages       P
				  INNER JOIN dbo.vw_Modules     M   ON P.PackageID=M.PackageID
				  INNER JOIN dbo.tabs           T   ON T.TabID=M.TabID
				  LEFT  JOIN #TabsLatestPublished                           TLP ON TLP.TabId = M.TabId AND TLP.ModuleId = M.ModuleID
				WHERE T.IsDeleted=0 AND (M.IsDeleted=0 OR (TLP.TabId IS NOT NULL AND TLP.ModuleId IS NOT NULL))
			) AS InUsePackages
				ON AllPackages.PackageID = InUsePackages.PackageID
		ORDER BY AllPackages.FriendlyName
	ELSE
		-- Get in use for portal or host only
		SELECT AllPackages.* FROM dbo.Packages AS AllPackages
			INNER JOIN (
				SELECT DISTINCT P.PackageID
				FROM         dbo.Packages       P
				  INNER JOIN dbo.vw_Modules     M   ON P.PackageID=M.PackageID
				  INNER JOIN dbo.tabs           T   ON T.TabID=M.TabID
				  LEFT  JOIN #TabsLatestPublished                           TLP ON TLP.TabId = M.TabId AND TLP.ModuleId = M.ModuleID
				WHERE ((@PortalID IS NULL AND T.PortalID IS NULL) OR T.PortalID = @PortalID)
				  AND T.IsDeleted=0
				  AND (M.IsDeleted=0 OR (TLP.TabId IS NOT NULL AND TLP.ModuleId IS NOT NULL))) AS InUsePackages	
			ON AllPackages.PackageID = InUsePackages.PackageID
		ORDER BY AllPackages.FriendlyName
END
GO
