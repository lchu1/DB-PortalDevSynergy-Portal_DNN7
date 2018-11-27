CREATE TABLE [dbo].[Links]
(
[ItemID] [int] NOT NULL IDENTITY(0, 1),
[ModuleID] [int] NOT NULL,
[CreatedDate] [datetime] NULL,
[Title] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Url] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ViewOrder] [int] NULL,
[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedByUser] [int] NOT NULL,
[RefreshInterval] [int] NULL,
[GrantRoles] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Links] ADD CONSTRAINT [PK__Links__727E83EB099F5001] PRIMARY KEY CLUSTERED  ([ItemID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Links] ON [dbo].[Links] ([ModuleID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Links] WITH NOCHECK ADD CONSTRAINT [FK_Links_Modules] FOREIGN KEY ([ModuleID]) REFERENCES [dbo].[Modules] ([ModuleID]) ON DELETE CASCADE
GO
