SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsRecurMasterDelete ***/

CREATE PROCEDURE [dbo].[EventsRecurMasterDelete]
    (
      @RecurMasterID INT
    , @ModuleID INT
    )
AS 
    DELETE  dbo.EventsRecurMaster
    WHERE   RecurMasterID = @RecurMasterID
            AND ModuleID = @ModuleID
GO
