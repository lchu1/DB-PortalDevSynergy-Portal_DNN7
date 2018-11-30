CREATE TABLE [dbo].[EventsLocation]
(
[PortalID] [int] NOT NULL,
[Location] [int] NOT NULL IDENTITY(1, 1),
[LocationName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MapURL] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Street] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PostalCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Region] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Country] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsLocation] ADD CONSTRAINT [PK_EventsLocation] PRIMARY KEY CLUSTERED  ([Location]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EventsLocation] ON [dbo].[EventsLocation] ([LocationName]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EventsLocation_2] ON [dbo].[EventsLocation] ([PortalID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsLocation] ADD CONSTRAINT [FK_EventsLocation_Portals] FOREIGN KEY ([PortalID]) REFERENCES [dbo].[Portals] ([PortalID]) ON DELETE CASCADE ON UPDATE CASCADE
GO
