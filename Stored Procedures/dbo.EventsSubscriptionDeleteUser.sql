SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsSubscriptionDeleteUser ***/

CREATE PROCEDURE [dbo].[EventsSubscriptionDeleteUser]
    (
      @UserID INT
    , @ModuleID INT
    )
AS 
    DELETE  dbo.EventsSubscription
    WHERE   UserID = @UserID
            AND ModuleID = @ModuleID
GO
