SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsNotificationGet ***/

CREATE PROCEDURE [dbo].[EventsNotificationGet]
    (
      @EventID INT
    , @UserEmail NVARCHAR(50)
    , @ModuleID INT
    )
AS 
    SELECT DISTINCT
            NotificationID
          , EventID
          , PortalAliasID
          , UserEmail
          , NotificationSent
          , NotifyByDateTime
          , EventTimeBegin
          , NotifyLanguage
          , n.ModuleID
          , n.TabID
    FROM    dbo.EventsNotification n
            LEFT OUTER JOIN dbo.EventsMaster m ON n.ModuleID = m.SubEventID
            LEFT OUTER JOIN dbo.EventsMaster m2 ON n.ModuleID = m2.ModuleID
    WHERE   EventID = @EventID
            AND UserEmail = @UserEmail
            AND (n.ModuleID = @ModuleID
             OR m.ModuleID = @ModuleID
             OR m2.SubEventID = @ModuleID)
GO
