SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsNotificationToSend ***/

CREATE PROCEDURE [dbo].[EventsNotificationsToSend]
(
    @NotifyTime DateTime
)
AS
SELECT     n.NotificationID, n.EventID, n.PortalAliasID, n.UserEmail, 
                      n.NotificationSent, n.NotifyByDateTime, n.EventTimeBegin, n.NotifyLanguage, 
                      n.ModuleID, n.TabID
FROM         dbo.[EventsNotification] as n 
WHERE     (n.NotificationSent = 0 and n.NotifyByDateTime < @NotifyTime)
ORDER BY n.NotifyByDateTime
GO
