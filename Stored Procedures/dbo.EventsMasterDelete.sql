SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[EventsMasterDelete]
    (
      @MasterID INT
    , @ModuleID INT
    )
AS 
    DELETE  dbo.EventsMaster
    WHERE   MasterID = @MasterID
            AND ModuleID = @ModuleID
GO
