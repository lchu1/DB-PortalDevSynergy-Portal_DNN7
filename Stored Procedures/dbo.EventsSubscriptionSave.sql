SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/* EventsSubscriptionSave */

CREATE PROCEDURE [dbo].[EventsSubscriptionSave]
    (
      @SubscriptionID INT
    , @ModuleID INT
    , @PortalID INT
    , @UserID INT
    )
AS 
    INSERT  dbo.EventsSubscription
            ( ModuleID, PortalID, UserID )
    VALUES  ( @ModuleID, @PortalID, @UserID )
      
    SELECT  SubscriptionID
          , ModuleID
          , PortalID
          , UserID
    FROM    dbo.EventsSubscription
    WHERE   SubscriptionID = SCOPE_IDENTITY()
            OR SubscriptionID = @SubscriptionID
GO
