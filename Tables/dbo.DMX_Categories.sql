CREATE TABLE [dbo].[DMX_Categories]
(
[CategoryId] [int] NOT NULL IDENTITY(1, 1),
[ParentId] [int] NOT NULL,
[PortalId] [int] NOT NULL,
[ViewOrder] [int] NULL,
[CategoryName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Categories] ADD CONSTRAINT [PK_DMX_Categories] PRIMARY KEY CLUSTERED  ([CategoryId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Categories] WITH NOCHECK ADD CONSTRAINT [FK_DMX_Categories_Portals] FOREIGN KEY ([PortalId]) REFERENCES [dbo].[Portals] ([PortalID]) ON DELETE CASCADE
GO
