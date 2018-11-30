SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsMasterGet ***/

CREATE PROCEDURE [dbo].[EventsMasterGet]
    (
      @ModuleID INT
    , @SubEventID INT
    )
AS 
    SELECT  @ModuleID AS ModuleID
          , b.PortalID
          , 0 AS MasterID
          , a.ModuleID AS SubEventID
    FROM    dbo.Modules a
            LEFT JOIN dbo.TabModules t
            ON a.ModuleID = t.ModuleID
            LEFT JOIN dbo.Tabs b
            ON t.TabID = b.TabID
    WHERE   a.ModuleID = @SubEventID
    GROUP BY b.PortalID
          , a.ModuleID
    ORDER BY b.PortalID
          , a.ModuleID
GO
