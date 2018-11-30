SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsUpgrade ***/

CREATE PROCEDURE [dbo].[EventsUpgrade] ( @Version VARCHAR(8) )
AS 
    IF @Version = '04.00.02' 
        BEGIN
-- Copy over Moderators from ModuleSettings
            INSERT  INTO dbo.[ModulePermission]
                    ( RoleID
                    , ModuleID
                    , PermissionID
                    , AllowAccess 
		            )
                    SELECT  dbo.[Modulesettings].SettingValue AS RoleID
                          , dbo.[Modulesettings].ModuleID
                          , dbo.[Permission].PermissionID
                          , -1 AS AllowAccess
                    FROM    dbo.[Modulesettings]
                            INNER JOIN dbo.[Modules]
                            ON dbo.[Modulesettings].ModuleID = dbo.[Modules].ModuleID
                            INNER JOIN dbo.[ModuleDefinitions]
                            ON dbo.[Modules].ModuleDefID = dbo.[ModuleDefinitions].ModuleDefID
                            CROSS JOIN dbo.[Permission]
                    WHERE   ( dbo.[Modulesettings].SettingName = 'moderatorroleid' )
                            AND ( dbo.[Modulesettings].SettingValue <> '0' )
                            AND ( dbo.[ModuleDefinitions].FriendlyName = N'Events' )
                            AND ( dbo.[Permission].PermissionCode = 'EVENTS_MODULE' )
                            AND ( dbo.[Permission].PermissionKey = 'EVENTSMOD' )

-- Ensure Moderators have edit permissions

            INSERT  INTO dbo.[ModulePermission]
                    ( RoleID
                    , ModuleID
                    , PermissionID
                    , AllowAccess 
		            )
                    SELECT  MP1.RoleID
                          , MP1.ModuleID
                          , P3.PermissionID
                          , -1 AS AllowAcces
                    FROM    dbo.[ModulePermission] AS MP1
                            INNER JOIN dbo.[Permission] AS P1
                            ON MP1.PermissionID = P1.PermissionID
                            CROSS JOIN dbo.[Permission] AS P3
                    WHERE   ( P1.PermissionCode = 'Events_Module' )
                            AND ( P1.PermissionKey = 'EVENTSMOD' )
                            AND ( MP1.RoleID NOT IN (
                                  SELECT    MP2.RoleID
                                  FROM      dbo.[ModulePermission] AS MP2
                                            INNER JOIN dbo.[Permission] AS P2
                                            ON MP2.PermissionID = P2.PermissionID
                                            INNER JOIN dbo.[Modules] AS M2
                                            ON MP2.ModuleID = M2.ModuleID
                                            INNER JOIN dbo.[ModuleDefinitions]
                                            AS MD2
                                            ON M2.ModuleDefID = MD2.ModuleDefID
                                  WHERE     ( P2.PermissionCode = 'SYSTEM_MODULE_DEFINITION' )
                                            AND ( P2.PermissionKey = 'EDIT' )
                                            AND ( MD2.FriendlyName = N'Events' )
                                            AND ( M2.ModuleID = MP1.ModuleID ) ) )
                            AND ( P3.PermissionCode = 'SYSTEM_MODULE_DEFINITION' )
                            AND ( P3.PermissionKey = 'EDIT' )

-- Delete Moderator settings from ModuleSettings

            DELETE  FROM dbo.[Modulesettings]
            FROM    dbo.[Modulesettings]
                    INNER JOIN dbo.[Modules]
                    ON dbo.[Modulesettings].ModuleID = dbo.[Modules].ModuleID
                    INNER JOIN dbo.[ModuleDefinitions]
                    ON dbo.[Modules].ModuleDefID = dbo.[ModuleDefinitions].ModuleDefID
            WHERE   ( dbo.[Modulesettings].SettingName = 'moderatorroleid' )
                    AND ( dbo.[ModuleDefinitions].FriendlyName = N'Events' )

        END

    IF @Version = '04.01.00' 
        BEGIN
            UPDATE  dbo.[EventsNotification]
            SET     EventID = E2.EventID
            FROM    dbo.[EventsNotification]
                    INNER JOIN dbo.[Events] AS E
                    ON dbo.[EventsNotification].EventID = E.EventID
                    LEFT OUTER JOIN dbo.[Events] AS E2
                    ON E.RecurMasterID = E2.RecurMasterID
                       AND dbo.[EventsNotification].EventTimeBegin = E2.EventTimeBegin
            WHERE   E2.EventTimeBegin IS NOT NULL
        END
GO
