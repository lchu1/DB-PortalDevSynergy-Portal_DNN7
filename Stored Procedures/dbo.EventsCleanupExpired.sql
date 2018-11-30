SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsCleanupExpired ***/

CREATE PROCEDURE [dbo].[EventsCleanupExpired]
(
    @PortalID int,
    @ModuleID int
)
AS

DELETE dbo.EventsRecurMaster 
    WHERE PortalID = @PortalID AND
      ModuleID = @ModuleID AND
      0 = (SELECT count(EventID) FROM dbo.Events
          WHERE dbo.Events.RecurMasterID = dbo.EventsRecurMaster.RecurMasterID 
            AND dbo.Events.Cancelled = 0)
GO
