SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetLogType]
 @LogTypeKey NVARCHAR (20),
 @PortalId INT
AS
SELECT
 *
FROM
 dbo.DMX_LogTypes
WHERE
 [LogTypeKey] = @LogTypeKey
 AND [PortalId] = @PortalId
GO
