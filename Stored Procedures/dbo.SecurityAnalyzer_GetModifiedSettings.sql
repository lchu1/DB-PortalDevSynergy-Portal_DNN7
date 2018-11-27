SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[SecurityAnalyzer_GetModifiedSettings]
AS
BEGIN
    SELECT TOP 20
            PortalID ,
            SettingName ,
            SettingValue ,
            LastModifiedByUserID ,
            LastModifiedOnDate
    FROM    dbo.[PortalSettings]
    ORDER BY LastModifiedOnDate DESC;

    SELECT TOP 20
            SettingName ,
            SettingValue ,
            LastModifiedByUserID ,
            LastModifiedOnDate
    FROM    dbo.[HostSettings]
    ORDER BY LastModifiedOnDate DESC;

    SELECT TOP 20
            t.TabID ,
            t.PortalID ,
            s.SettingName ,
            s.SettingValue ,
            s.LastModifiedByUserID ,
            s.LastModifiedOnDate
    FROM    dbo.[TabSettings] s
            INNER JOIN dbo.[Tabs] t ON t.TabID = s.TabID
    ORDER BY s.LastModifiedOnDate DESC;

    SELECT TOP 20
            T.*
    FROM    ( SELECT    'Module Settings' as Type,
                        m.ModuleID ,
                        m.PortalID ,
                        SettingName ,
                        SettingValue ,
                        ms.LastModifiedByUserID ,
                        ms.LastModifiedOnDate
              FROM      dbo.[ModuleSettings] ms
                        INNER JOIN dbo.[Modules] m ON m.ModuleID = ms.ModuleID
              UNION
              ( SELECT  'TabModule Settings' as Type,
                        tm.ModuleID ,
                        m.PortalID ,
                        ts.SettingName ,
                        ts.SettingValue ,
                        ts.LastModifiedByUserID ,
                        ts.LastModifiedOnDate
                FROM    dbo.[TabModuleSettings] ts
                        INNER JOIN dbo.[TabModules] tm ON tm.TabModuleID = ts.TabModuleID
                        INNER JOIN dbo.[Modules] m ON m.ModuleID = tm.ModuleID
              )
            ) T
            INNER JOIN dbo.[Modules] m ON m.ModuleID = T.ModuleID
    ORDER BY T.LastModifiedOnDate DESC;
END
GO
