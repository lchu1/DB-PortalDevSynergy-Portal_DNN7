SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddProvider]
 @Provider NVARCHAR (255), 
 @ProviderName NVARCHAR (255), 
 @ProviderType INT
AS
INSERT INTO dbo.DMX_Providers (
 [Provider],
 [ProviderName],
 [ProviderType]
)
 VALUES ( @Provider, @ProviderName, @ProviderType)
select SCOPE_IDENTITY()
GO
