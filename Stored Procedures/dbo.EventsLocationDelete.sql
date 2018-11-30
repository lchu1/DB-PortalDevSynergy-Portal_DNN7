SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsLocationDelete ***/

CREATE PROCEDURE [dbo].[EventsLocationDelete]
    (
      @Location INT
    , @PortalID INT
    )
AS 
    UPDATE  dbo.EventsRecurMaster
    SET     Location = NULL
    WHERE   Location = @Location
            AND PortalID = @PortalID
    UPDATE  dbo.Events
    SET     Location = NULL
    WHERE   Location = @Location
            AND PortalID = @PortalID
    DELETE  dbo.EventsLocation
    WHERE   Location = @Location
            AND PortalID = @PortalID
GO
