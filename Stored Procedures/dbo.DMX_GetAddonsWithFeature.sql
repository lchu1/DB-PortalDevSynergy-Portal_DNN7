SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetAddonsWithFeature]
 @Feature INT
AS
SELECT
 *
FROM
 dbo.DMX_Addons
WHERE
 ISNULL([Features], 0) & @Feature = @Feature
GO
