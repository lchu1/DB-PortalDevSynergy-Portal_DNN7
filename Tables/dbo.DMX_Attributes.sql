CREATE TABLE [dbo].[DMX_Attributes]
(
[Addon] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AttributeId] [int] NOT NULL IDENTITY(1, 1),
[ControlToLoad] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsPrivate] [bit] NULL,
[Key] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PortalId] [int] NULL,
[Required] [bit] NULL,
[ResourceFile] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Values] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ValueType] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ViewOrder] [int] NULL,
[CollectionId] [int] NOT NULL,
[ShowInUI] [bit] NULL,
[AttributeName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Attributes] ADD CONSTRAINT [PK_DMX_Attributes] PRIMARY KEY CLUSTERED  ([AttributeId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Attributes] WITH NOCHECK ADD CONSTRAINT [FK_DMX_Attributes_Addons] FOREIGN KEY ([Addon]) REFERENCES [dbo].[DMX_Addons] ([AddonKey]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DMX_Attributes] WITH NOCHECK ADD CONSTRAINT [FK_DMX_Attributes_Portals] FOREIGN KEY ([PortalId]) REFERENCES [dbo].[Portals] ([PortalID]) ON DELETE CASCADE
GO
