SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UpdateProvider]
 @Provider NVARCHAR (255), 
 @ProviderID INT, 
 @ProviderName NVARCHAR (255), 
 @ProviderType INT
AS
UPDATE dbo.DMX_Providers SET
 [Provider] = @Provider,
 [ProviderName] = @ProviderName,
 [ProviderType] = @ProviderType
WHERE
 [ProviderID] = @ProviderID
GO
