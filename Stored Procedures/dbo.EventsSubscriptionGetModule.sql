SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/* EventsSubscriptionGetModule */

CREATE PROCEDURE [dbo].[EventsSubscriptionGetModule] ( @ModuleID INT )
AS 
    SELECT  SubscriptionID
          , ModuleID
          , PortalID
          , UserID
    FROM    dbo.EventsSubscription
    WHERE   ModuleID = @ModuleID
GO
