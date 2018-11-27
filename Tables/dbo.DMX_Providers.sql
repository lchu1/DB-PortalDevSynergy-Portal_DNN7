CREATE TABLE [dbo].[DMX_Providers]
(
[Provider] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProviderID] [int] NOT NULL IDENTITY(1, 1),
[ProviderName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProviderType] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Providers] ADD CONSTRAINT [PK_DMX_Providers] PRIMARY KEY CLUSTERED  ([ProviderID]) ON [PRIMARY]
GO
