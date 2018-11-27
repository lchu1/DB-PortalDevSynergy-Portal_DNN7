SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetExtensionsByAddon]
 @Addon NVarChar (50)
AS
SELECT
 *
FROM
 dbo.DMX_Extensions
WHERE
 Addon = @Addon
GO
