SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetExtension]
 @ExtensionKey NVARCHAR (50),
 @PortalId INT
AS
SELECT
 *
FROM
 dbo.DMX_Extensions
WHERE
 [ExtensionKey] = @ExtensionKey
 AND [PortalId] = @PortalId
GO
