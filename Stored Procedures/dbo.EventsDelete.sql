SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[EventsDelete]
    (
      @EventID INT
    , @ModuleID INT
    )
AS 
    DELETE  FROM dbo.Events
    FROM    dbo.Events
            LEFT OUTER JOIN dbo.EventsMaster
            ON dbo.Events.ModuleID = dbo.EventsMaster.SubEventID
    WHERE   EventID = @EventID
            AND ( dbo.Events.ModuleID = @ModuleID
                  OR dbo.EventsMaster.ModuleID = @ModuleID
                )
GO
