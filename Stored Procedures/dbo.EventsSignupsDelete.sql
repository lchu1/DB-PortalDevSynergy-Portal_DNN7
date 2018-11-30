SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[EventsSignupsDelete]
    (
      @SignupID INT
    , @ModuleID INT
    )
AS 
    DELETE  FROM dbo.EventsSignups
    FROM    dbo.EventsSignups
            LEFT OUTER JOIN dbo.EventsMaster
            ON dbo.EventsSignups.ModuleID = dbo.EventsMaster.SubEventID
    WHERE   SignupID = @SignupID
            AND ( dbo.EventsSignups.ModuleID = @ModuleID
                  OR dbo.EventsMaster.ModuleID = @ModuleID
                )
GO
