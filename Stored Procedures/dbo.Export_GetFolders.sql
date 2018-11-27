SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_GetFolders]
    @PortalID  int,
	@ToDate    datetime,
    @FromDate  datetime=NULL
AS
    SELECT    F.*,PF.FolderPath ParentFolderPath,FM.MappingName FolderMappingName,dbo.[Export_UserName](F.CreatedByUserId) CreatedByUserName,dbo.[Export_UserName](F.LastModifiedByUserId) LastModifiedByUserName
    FROM    
        dbo.[Folders]  F 
		INNER JOIN dbo.[FolderMappings] FM ON F.[FolderMappingID]=FM.[FolderMappingID]
		LEFT JOIN dbo.[Folders] PF ON F.ParentID=PF.FolderID
    WHERE  F.PortalID = @PortalID
    AND 
        (CASE 
        WHEN @FromDate IS NULL THEN 0
        WHEN F.LastModifiedOnDate IS NULL THEN F.CreatedOnDate 
        ELSE ISNULL(F.LastModifiedOnDate,0) END)>= ISNULL(@FromDate,0)
    AND (CASE
			WHEN F.LastModifiedOnDate IS NULL THEN F.CreatedOnDate
			ELSE F.LastModifiedOnDate END)<= @ToDate
	ORDER BY F.PortalID, F.CreatedOnDate, F.FolderPath
GO
