SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetDocuments]
	@ModuleId INT,
	@PortalId INT
AS
SELECT Documents.ItemId,
        Documents.Moduleid,
       Documents.Title,
       Documents.Url,
       CreatedByUser.FirstName + ' ' + CreatedByUser.LastName AS "CreatedByUser",
       OwnedByUser.FirstName + ' ' + OwnedByUser.LastName AS "OwnedByUser",
       ModifiedByUser.FirstName + ' ' + ModifiedByUser.LastName AS "ModifiedByUser",       
       Documents.Category,
       Files.Size,
       UrlTracking.TrackClicks,
       UrlTracking.Clicks,
       UrlTracking.NewWindow,
       Documents.OwnedByUserID, 
       Documents.ModifiedByUserID, 
       Documents.ModifiedDate,
       Documents.CreatedByUserID, 
       Documents.CreatedDate, 
       Documents.SortOrderIndex,
       Documents.Description,
	   Documents.ForceDownload
FROM dbo.Documents
LEFT OUTER JOIN dbo.Users AS CreatedByUser on dbo.Documents.CreatedByUserID = CreatedByUser.UserId 
LEFT OUTER JOIN dbo.Users AS OwnedByUser on dbo.Documents.OwnedByUserID = OwnedByUser.UserId
LEFT OUTER JOIN dbo.Users  AS ModifiedByUser on dbo.Documents.ModifiedByUserID = ModifiedByUser.UserId
LEFT OUTER JOIN dbo.Files on dbo.Documents.URL = 'fileid=' + convert(varchar,dbo.Files.FileID)
LEFT OUTER JOIN dbo.UrlTracking on dbo.Documents.URL = dbo.UrlTracking.Url and dbo.UrlTracking.ModuleId = @ModuleID
WHERE  Documents.ModuleId = @ModuleId
ORDER by Documents.Title
GO
