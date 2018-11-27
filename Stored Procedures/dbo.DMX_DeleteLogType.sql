SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeleteLogType]
 @LogTypeKey NVARCHAR (20),
 @PortalId INT
AS
DELETE FROM dbo.DMX_LogTypes
WHERE
 [LogTypeKey] = @LogTypeKey
 AND [PortalId] = @PortalId
GO
