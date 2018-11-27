SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetTabsByPackageID]
    @PortalId  Int, -- Null for Host menu items
    @PackageId Int, -- Not Null!
    @ForHost   Bit  -- 0: Get pages for a specific portal (OR host pages only)
                    -- 1: Get all host pages and portal pages
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
	
    SELECT * FROM dbo.[vw_Tabs]
    WHERE (IsNull(PortalId, -1) = IsNull(@PortalId, -1) Or @ForHost = 1)
		AND IsDeleted = 0
		AND TabId IN (SELECT M.TabId FROM dbo.[vw_Modules] M
					  LEFT JOIN #TabsLatestPublished TLP ON TLP.TabId = M.TabId AND TLP.ModuleId = M.ModuleID
                      WHERE M.PackageID = @PackageId AND (M.IsDeleted = 0 OR (TLP.TabId IS NOT NULL AND TLP.ModuleId IS NOT NULL)))
    ORDER BY PortalID, TabName
	OPTION (OPTIMIZE FOR (@PortalId UNKNOWN, @PackageId UNKNOWN, @ForHost UNKNOWN));
END
GO
