SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/* EventsSubscriptionGetSubModule */

CREATE PROCEDURE [dbo].[EventsSubscriptionGetSubModule] ( @ModuleID INT )
AS 
    SELECT DISTINCT
            S.SubscriptionID
          , S.ModuleID
          , S.PortalID
          , S.UserID
    FROM    dbo.EventsSubscription AS S
            LEFT OUTER JOIN dbo.EventsMaster AS M
            ON S.ModuleID = M.ModuleID
    WHERE   ( S.ModuleID = @ModuleID )
            OR ( SubEventID = @ModuleID )
GO
