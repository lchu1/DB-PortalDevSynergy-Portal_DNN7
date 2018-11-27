SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetBreadCrumbs]
 @RootId INT,
 @EntryId INT,
 @Locale VARCHAR(10)
AS
DECLARE @BCPath VARCHAR(4000)
SELECT @BCPath = [Path] FROM dbo.DMX_Entries WHERE EntryId=@EntryId
DECLARE @StartPath VARCHAR(4000)
SELECT @StartPath = [Path] FROM dbo.DMX_Entries WHERE EntryId=@RootId
SET @StartPath = ISNULL(@StartPath, '0;') 
SET @BCPath=REPLACE(@BCPath, @StartPath, CAST(@RootId AS VARCHAR(10))+';')
SELECT
 e.Author, e.CollectionId, e.Deleted, e.Entry, e.EntryId, e.EntryType, e.FileSize, e.Created, e.IsApproved,
 e.Keywords, e.LastModified, e.LastVersionId, e.LockedBy, e.LockedUntil, e.LockKey, e.MD5Hash, e.OriginalFileName,
 e.Owner, e.PortalId, e.State, e.Version, e.VersionsToKeep, e.WorkflowId, e.Path, e.PermissionsOnlyByAdmin,
 e.InheritAttributes, e.StorageProviderID, e.Thumbnail, e.Hidden,
 ISNULL(el.Title, e.Title) Title, ISNULL(el.Remarks, e.Remarks) Remarks
FROM dbo.DMX_Split(@BCPath, ';')
 INNER JOIN dbo.DMX_Entries e ON e.EntryId=s
 LEFT JOIN dbo.DMX_EntriesML el ON e.EntryId=el.EntryId AND el.Locale=@Locale
WHERE NOT s=''
GO
