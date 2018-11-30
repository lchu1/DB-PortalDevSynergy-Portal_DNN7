CREATE TABLE [dbo].[EventsMaster]
(
[MasterID] [int] NOT NULL IDENTITY(1, 1),
[ModuleID] [int] NOT NULL,
[SubEventID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsMaster] ADD CONSTRAINT [PK_EventsMaster] PRIMARY KEY CLUSTERED  ([MasterID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsMaster] ADD CONSTRAINT [IX_EventsMaster] UNIQUE NONCLUSTERED  ([MasterID], [SubEventID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EventsMaster_1] ON [dbo].[EventsMaster] ([ModuleID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventsMaster] ADD CONSTRAINT [FK_EventsMaster_Modules] FOREIGN KEY ([ModuleID]) REFERENCES [dbo].[Modules] ([ModuleID]) ON DELETE CASCADE ON UPDATE CASCADE
GO
