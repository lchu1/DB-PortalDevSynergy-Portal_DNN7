SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsMasterSave ***/

CREATE PROCEDURE [dbo].[EventsMasterSave]
    (
      @MasterID INT
    , @ModuleID INT
    , @SubEventID INT
    )
AS 
    IF @MasterID = 0
        OR @MasterID IS NULL 
        INSERT  dbo.EventsMaster
                ( ModuleID, SubEventID )
        VALUES  ( @ModuleID, @SubEventID )
    ELSE 
        UPDATE  dbo.EventsMaster
        SET     ModuleID = @ModuleID
              , SubEventID = @SubEventID
        WHERE   MasterID = @MasterID

    SELECT  a.MasterID
          , a.ModuleID
          , a.SubEventID
    FROM    dbo.EventsMaster a
    WHERE   a.MasterID = SCOPE_IDENTITY()
    GROUP BY a.MasterID
          , a.ModuleID
          , a.SubEventID
GO
