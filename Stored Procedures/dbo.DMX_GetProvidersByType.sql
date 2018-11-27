SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetProvidersByType]
 @ProviderType Int
AS
SELECT
 *
FROM
 dbo.DMX_Providers
WHERE
 [ProviderType] = @ProviderType
GO
