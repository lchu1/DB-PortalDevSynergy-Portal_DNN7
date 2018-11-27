SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [dbo].[DeletePortalAlias]
    @PortalAliasID INT
AS
    DELETE FROM dbo.[PortalAlias]
        WHERE PortalAliasID = @PortalAliasID
        
    UPDATE 	dbo.[TabUrls]
        SET PortalAliasID = NULL WHERE PortalAliasID = @PortalAliasID
GO
