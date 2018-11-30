CREATE TABLE [dbo].[EventsCategory]
(
[PortalID] [int] NOT NULL,
[Category] [int] NOT NULL IDENTITY(1, 1),
[CategoryName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Color] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FontColor] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsCategory] ADD CONSTRAINT [PK_EventsCategory] PRIMARY KEY CLUSTERED  ([Category]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EventsCategory] ON [dbo].[EventsCategory] ([CategoryName]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EventsCategory_2] ON [dbo].[EventsCategory] ([PortalID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsCategory] ADD CONSTRAINT [FK_EventsCategory_Portals] FOREIGN KEY ([PortalID]) REFERENCES [dbo].[Portals] ([PortalID]) ON DELETE CASCADE ON UPDATE CASCADE
GO
