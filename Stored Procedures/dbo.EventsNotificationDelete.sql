SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[EventsNotificationDelete]
    (
      @DeleteDateTime DATETIME
    )
AS 
    DELETE  dbo.EventsNotification
    WHERE   NotifyBydateTime <= @DeleteDateTime
            AND NotificationSent != 0
GO
