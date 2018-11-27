SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_GetFiles]
    @PortalID    int,
    @FolderID    int,
	@ToDate      datetime,
	@FromDate    datetime=NULL
AS
    SELECT F.*,dbo.[Export_UserName](CreatedByUserId) CreatedByUserName,dbo.[Export_UserName](LastModifiedByUserId) LastModifiedByUserName
    FROM    
        dbo.[vw_PublishedFiles] F
    WHERE (F.FolderID = @FolderID OR @FolderID IS NULL) AND F.PortalID = @PortalID
	AND 
        (CASE 
        WHEN @FromDate IS NULL THEN 0
        WHEN F.LastModifiedOnDate IS NULL THEN F.CreatedOnDate 
        ELSE F.LastModifiedOnDate END)>= ISNULL(@FromDate,0)
	AND (CASE
			WHEN F.LastModifiedOnDate IS NULL THEN F.CreatedOnDate
			ELSE F.LastModifiedOnDate END)<= @ToDate
    ORDER BY [FolderID], [FileName]
GO
