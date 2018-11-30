SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsCategoryDelete ***/

CREATE PROCEDURE [dbo].[EventsCategoryDelete]
    (
      @Category INT
    , @PortalID INT
    )
AS 
    UPDATE  dbo.EventsRecurMaster
    SET     Category = NULL
    WHERE   Category = @Category
            AND PortalID = @PortalID
    UPDATE  dbo.Events
    SET     Category = NULL
    WHERE   Category = @Category
            AND PortalID = @PortalID
    DELETE  dbo.EventsCategory
    WHERE   Category = @Category
            AND PortalID = @PortalID
GO
