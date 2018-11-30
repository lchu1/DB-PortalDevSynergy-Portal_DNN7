SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsNotificationSave ***/

CREATE PROCEDURE [dbo].[EventsNotificationSave]
    (
      @NotificationID INT
    , @EventID INT
    , @PortalAliasID INT
    , @UserEmail NVARCHAR(50)
    , @NotificationSent BIT
    , @NotifyByDateTime DATETIME
    , @EventTimeBegin DATETIME
    , @NotifyLanguage NVARCHAR(10)
    , @ModuleID INT
    , @TabID INT
    )
AS 
    SET DATEFORMAT mdy
    IF @NotificationID = -1
        OR @NotificationID IS NULL 
        INSERT  dbo.EventsNotification
                ( EventID
                , PortalAliasID
                , UserEmail
                , NotificationSent
                , NotifyByDateTime
                , EventTimeBegin
                , NotifyLanguage
                , ModuleID
                , TabID
	            )
        VALUES  ( @EventID
                , @PortalAliasID
                , @UserEmail
                , @NotificationSent
                , @NotifyByDateTime
                , @EventTimeBegin
                , @NotifyLanguage
                , @ModuleID
                , @TabID
	            )
    ELSE 
        UPDATE  dbo.EventsNotification
        SET     EventID = @EventID
              , PortalAliasID = @PortalAliasID
              , UserEmail = @UserEmail
              , NotificationSent = @NotificationSent
              , NotifyByDateTime = @NotifyByDateTime
              , EventTimeBegin = @EventTimeBegin
              , NotifyLanguage = @NotifyLanguage
              , TabID = @TabID
        WHERE   NotificationID = @NotificationID
                AND ModuleID = @ModuleID

    SELECT  *
    FROM    dbo.EventsNotification
    WHERE   NotificationID = SCOPE_IDENTITY()
GO
