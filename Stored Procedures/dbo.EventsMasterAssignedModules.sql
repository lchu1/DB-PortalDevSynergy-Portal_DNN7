SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsMasterAssignedModules ***/

CREATE PROCEDURE [dbo].[EventsMasterAssignedModules] ( @ModuleID INT )
AS 
    SELECT  a.ModuleID AS ModuleID
          , 0 AS PortalID
          , a.MasterID
          , a.SubEventID AS SubEventID
    FROM    dbo.EventsMaster a
            LEFT JOIN dbo.TabModules t
            ON a.SubEventID = t.ModuleID
    WHERE   a.ModuleID = @ModuleID
            AND t.IsDeleted = 0
    GROUP BY a.MasterID
          , a.ModuleID
          , a.SubEventID
    ORDER BY a.MasterID
GO
