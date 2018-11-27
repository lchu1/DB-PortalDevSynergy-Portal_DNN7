SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetPortalLocalizations]
    @PortalId			int
AS
	SELECT * FROM dbo.[PortalLocalization] WHERE PortalId = @PortalId
GO
