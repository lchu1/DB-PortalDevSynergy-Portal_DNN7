SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetLogTypes]
 @PortalId Int
AS
SELECT
 lt.*
FROM
 dbo.DMX_LogTypes lt
WHERE
 [PortalId] = @PortalId
GO
