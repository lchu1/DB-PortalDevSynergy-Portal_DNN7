SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_DeleteProvider]
 @ProviderID INT
AS
DELETE FROM dbo.DMX_Providers
WHERE
 [ProviderID] = @ProviderID
GO