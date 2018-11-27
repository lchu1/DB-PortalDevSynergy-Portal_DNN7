SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetDocument]
	@ItemId   INT,
	@ModuleId INT
AS
SELECT Documents.Itemid,
       Documents.Moduleid,
       Documents.Title,
       Documents.Url,
       Documents.Category,
       CreatedByUser.FirstName + ' ' + CreatedByUser.LastName AS "CreatedByUser",
       OwnedByUser.FirstName + ' ' + OwnedByUser.LastName AS "OwnedByUser",
       ModifiedByUser.FirstName + ' ' + ModifiedByUser.LastName AS "ModifiedByUser",       
       Files.Size,
       Files.ContentType,
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
LEFT OUTER JOIN dbo.Users AS CreatedByUser on Documents.CreatedByUserID = CreatedByUser.UserId 
LEFT OUTER JOIN dbo.Users AS OwnedByUser on Documents.OwnedByUserID = OwnedByUser.UserId
LEFT OUTER JOIN dbo.Users  AS ModifiedByUser on Documents.ModifiedByUserID = ModifiedByUser.UserId
LEFT OUTER JOIN dbo.UrlTracking on Documents.URL = UrlTracking.Url and UrlTracking.ModuleId = @ModuleID
LEFT OUTER JOIN dbo.Files on Documents.URL = 'fileid=' +
convert(varchar,dbo.Files.FileID)
WHERE  dbo.Documents.ItemId = @ItemId
and    dbo.Documents.ModuleId = @ModuleId
GO
