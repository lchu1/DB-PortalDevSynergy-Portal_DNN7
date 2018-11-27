SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetEntriesByPortal]
 @PortalId INT,
 @IncludeDeleted BIT,
 @Locale NVARCHAR(10),
 @PageSize INT = 0,
 @StartRecord INT = 1
AS
SELECT *
FROM
(SELECT
 ROW_NUMBER() OVER (ORDER BY e.EntryId) AS rownum,
 e.Author, e.CollectionId, e.Deleted, e.Entry, e.EntryId, e.EntryType, e.FileSize, e.Created, e.IsApproved,
 e.Keywords, e.LastModified, e.LastVersionId, e.LockedBy, e.LockedUntil, e.LockKey, e.MD5Hash, e.OriginalFileName,
 e.Owner, e.PortalId, e.State, e.Version, e.VersionsToKeep, e.WorkflowId, e.Path, e.PermissionsOnlyByAdmin,
 e.InheritAttributes, e.StorageProviderID, e.Thumbnail, e.Hidden,
 ISNULL(el.Title, e.Title) Title, ISNULL(el.Remarks, e.Remarks) Remarks
FROM
 dbo.DMX_Entries e
 LEFT JOIN dbo.DMX_EntriesML el ON e.EntryId=el.EntryId AND el.Locale=@Locale
WHERE
 e.PortalId = @PortalId
 AND ((NOT e.Deleted = 1) OR (@IncludeDeleted = 1))) AS tmp
WHERE (@PageSize=0 OR (rownum >= @StartRecord AND rownum < @StartRecord + @PageSize))
GO
