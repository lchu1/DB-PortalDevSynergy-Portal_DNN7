SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsMasterAvailableModules ***/

CREATE PROCEDURE [dbo].[EventsMasterAvailableModules]
(
    @PortalID int,
    @ModuleID int
)
AS
BEGIN
SET NOCOUNT ON;
SET DATEFORMAT mdy;

Select @ModuleID as ModuleID, c.PortalID, 0 as MasterID, a.ModuleID as SubEventID
from dbo.Modules a
  left join dbo.ModuleDefinitions b on a.ModuleDefID = b.ModuleDefID 
  left join dbo.DesktopModules d on b.DesktopModuleID = d.DesktopModuleID
  left join dbo.TabModules t on a.ModuleID = t.ModuleID
  left join dbo.Tabs c on t.TabID = c.TabID
  where
     d.ModuleName = 'DNN_Events' AND 
     c.PortalID = @PortalID and 
     a.ModuleID Not In  (select SubEventID from dbo.EventsMaster where ModuleID = @ModuleID) AND
     a.ModuleID Not In (select ModuleID from dbo.EventsMaster where SubEventID = @ModuleID) AND
     a.ModuleID Not In (select ModuleID from dbo.EventsMaster where ModuleID = a.ModuleID) AND
     a.ModuleID != @ModuleID AND
     t.IsDeleted = 0
Group BY c.PortalID, a.ModuleID 
Order By c.PortalID, a.ModuleID 
END
GO
