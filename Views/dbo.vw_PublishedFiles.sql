SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_PublishedFiles]
AS
    SELECT     
       fi.[FileId]
      ,fi.[PortalId]
      ,fi.[FileName]
      ,fi.[Extension]
      ,fi.[Size]
      ,fi.[Width]
      ,fi.[Height]
      ,fi.[ContentType]
      ,fi.[FolderID]
      ,fi.[Content]
      ,fi.[CreatedByUserID]
      ,fi.[CreatedOnDate]
      ,fi.[LastModifiedByUserID]
      ,fi.[LastModifiedOnDate]
      ,fi.[UniqueId]
      ,fi.[VersionGuid]
      ,fi.[SHA1Hash]
      ,fi.[LastModificationTime]
      ,fi.[Title]
      ,fi.[Description]
      ,fi.[StartDate]
      ,fi.[EnablePublishPeriod]
      ,fi.[EndDate]
      ,fi.[ContentItemID]
      ,fi.[PublishedVersion]
      ,fi.[Folder]
      ,fi.[IsCached]
      ,fi.[StorageLocation]
      ,fi.[FolderMappingID]
      ,fi.[HasBeenPublished]
    FROM       dbo.[vw_Files] fi
      WHERE ([EnablePublishPeriod] = 0 AND [HasBeenPublished] = 1)
         OR ([StartDate] <= GETDATE()
            AND ([EndDate] IS NULL OR GETDATE() <= [EndDate]) AND [HasBeenPublished] = 1)
GO
