SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetLogsByPortal]
 @PortalId Int
AS
SELECT
 *
FROM
 dbo.vw_DMX_Log
WHERE
 PortalId = @PortalId
GO