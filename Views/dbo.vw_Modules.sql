SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_Modules]
AS
    SELECT
        M.PortalID AS [OwnerPortalID],
        DM.PackageID,
        T.PortalID,
        TM.TabID,
        TM.TabModuleID,
        M.ModuleID,
        M.ModuleDefID,
        TM.ModuleOrder,
        TM.PaneName,
        TM.ModuleTitle,
        TM.CacheTime,
        TM.CacheMethod,
        TM.Alignment,
        TM.Color,
        TM.Border,
        CASE WHEN TM.IconFile LIKE 'fileid=%' 
			THEN (SELECT IsNull(Folder, '') + [FileName] FROM dbo.[vw_Files]
				  WHERE FileId = CAST(SUBSTRING(TM.IconFile, 8, 10) AS Int))
			ELSE Coalesce(TM.IconFile,'')
		END AS IconFile,
        TM.Visibility,
        TM.Header,
        TM.Footer,
        TM.ContainerSrc,
        TM.DisplayTitle,
        TM.DisplayPrint,
        TM.DisplaySyndicate,
        TM.IsWebSlice,
        TM.WebSliceTitle,
        TM.WebSliceExpiryDate,
        TM.WebSliceTTL,
        TM.UniqueId,
        TM.VersionGuid,
        TM.DefaultLanguageGuid,
        TM.LocalizedVersionGuid,
        TM.CultureCode,
        M.AllTabs,
        M.StartDate,
        M.EndDate,
        T.StartDate AS TabStartDate,
        T.EndDate AS TabEndDate,
        M.InheritViewPermissions,
        M.IsShareable,
        M.IsShareableViewOnly,
        M.CreatedByUserID,
        M.CreatedOnDate,
        M.LastModifiedByUserID,
        M.LastModifiedOnDate,
        M.LastContentModifiedOnDate,
        MD.DesktopModuleID,
        MD.DefaultCacheTime,
        MD.DefinitionName,
        MC.ModuleControlID,
        DM.BusinessControllerClass,
        DM.IsAdmin,
        DM.SupportedFeatures,
        CI.ContentItemID,
        CI.Content,
        CI.ContentTypeID,
        CI.ContentKey,
        CI.Indexed,
        CI.StateID,
        TM.IsDeleted AS IsDeleted,
        M.IsDeleted  AS IsModuleDeleted,
		T.IsDeleted  AS IsTabDeleted
    FROM        dbo.[ModuleDefinitions] AS MD
     INNER JOIN dbo.[Modules]           AS M  ON M.ModuleDefID = MD.ModuleDefID
     INNER JOIN dbo.[ModuleControls]    AS MC ON MD.ModuleDefID = MC.ModuleDefID
     INNER JOIN dbo.[DesktopModules]    AS DM ON MD.DesktopModuleID = DM.DesktopModuleID
     LEFT  JOIN dbo.[ContentItems]      AS CI ON M.ContentItemID = CI.ContentItemID
     LEFT  JOIN dbo.[TabModules]        AS TM ON M.ModuleID = TM.ModuleID
     LEFT  JOIN dbo.[Tabs]              AS T  ON TM.TabID = T.TabID
    WHERE (MC.ControlKey IS NULL)
GO
