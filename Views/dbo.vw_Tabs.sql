SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_Tabs]
AS
    SELECT
        T.TabID,
        T.TabOrder,
        T.PortalID,
        T.TabName,
        T.ParentId,
        T.[Level],
        T.TabPath,
        T.UniqueId,
        T.VersionGuid,
        T.DefaultLanguageGuid,
        T.LocalizedVersionGuid,
        T.IsVisible,
		T.HasBeenPublished,
		 Case when t.IconFile LIKE 'fileid=%' 
			then (SELECT IsNull(Folder, '') + [FileName] FROM dbo.[vw_Files]
			 WHERE fileid = CAST(SUBSTRING(t.IconFile, 8, 10) AS Int))
			 else Coalesce(t.IconFile,'')
			 end as IconFile
		,
         Case when t.IconFileLarge LIKE 'fileid=%' 
			then (SELECT IsNull(Folder, '') + [FileName] FROM dbo.[vw_Files]
			 WHERE fileid = CAST(SUBSTRING(t.IconFileLarge, 8, 10) AS Int))
			 else Coalesce(t.IconFileLarge,'')
			 end as IconFileLarge
		,T.DisableLink,
        T.Title,
        T.Description,
        T.KeyWords,
        T.IsDeleted,
        T.SkinSrc,
        T.ContainerSrc,
        T.StartDate,
        T.EndDate,
        T.Url,
        CASE WHEN dbo.HasChildTab(T.TabID) = 1 THEN 'true' ELSE 'false' END AS HasChildren,
        T.RefreshInterval,
        T.PageHeadText,
        T.IsSecure,
        T.PermanentRedirect,
        T.SiteMapPriority,
        CI.ContentItemID,
        CI.[Content],
        CI.ContentTypeID,
        CI.ModuleID,
        CI.ContentKey,
        CI.Indexed,
        CI.StateID,
        T.CultureCode,
        T.CreatedByUserID,
        T.CreatedOnDate,
        T.LastModifiedByUserID,
        T.LastModifiedOnDate,
		T.IsSystem
    FROM       dbo.[Tabs]         AS T
    LEFT  JOIN dbo.[ContentItems] AS CI ON T.ContentItemID = CI.ContentItemID
GO
