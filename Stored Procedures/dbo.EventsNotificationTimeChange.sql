SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsNotificationTimeChange ***/

CREATE PROCEDURE [dbo].[EventsNotificationTimeChange]
    (
      @EventID INT
    , @EventTimeBegin DATETIME
    , @ModuleID INT
    )
AS 
    SET DATEFORMAT mdy

    UPDATE  dbo.EventsNotification
    SET     NotifyByDateTime = DATEADD(n,
                                       -( SELECT    DATEDIFF(minute,
                                                             NotifyByDateTime,
                                                             EventTimeBegin)
                                          FROM      dbo.EventsNotification
                                                    LEFT OUTER JOIN dbo.EventsMaster
                                                    ON dbo.EventsNotification.ModuleID = dbo.EventsMaster.SubEventID
                                          WHERE     EventID = @EventID
                                                    AND ( dbo.EventsNotification.ModuleID = @ModuleID
                                                          OR dbo.EventsMaster.ModuleID = @ModuleID
                                                        )
                                        ), @EventTimeBegin)
          , EventTimeBegin = @EventTimeBegin
    FROM    dbo.EventsNotification
            LEFT OUTER JOIN dbo.EventsMaster
            ON dbo.EventsNotification.ModuleID = dbo.EventsMaster.SubEventID
    WHERE   EventID = @EventID
            AND ( dbo.EventsNotification.ModuleID = @ModuleID
                  OR dbo.EventsMaster.ModuleID = @ModuleID
                )
GO
