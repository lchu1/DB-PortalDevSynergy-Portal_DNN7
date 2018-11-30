SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/* EventsSubscriptionGetUser */

CREATE PROCEDURE [dbo].[EventsSubscriptionGetUser]
    (
      @UserID INT
    , @ModuleID INT
    )
AS 
    SELECT  SubscriptionID
          , ModuleID
          , PortalID
          , UserID
    FROM    dbo.EventsSubscription
    WHERE   UserID = @UserID
            AND ModuleID = @ModuleID
GO
