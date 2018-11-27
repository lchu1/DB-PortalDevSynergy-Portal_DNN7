CREATE TABLE [dbo].[Documents]
(
[ItemID] [int] NOT NULL IDENTITY(0, 1),
[ModuleID] [int] NOT NULL,
[CreatedDate] [datetime] NULL,
[URL] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Title] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Category] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedByUserID] [int] NULL,
[OwnedByUserID] [int] NULL,
[ModifiedByUserID] [int] NULL,
[ModifiedDate] [datetime] NULL,
[SortOrderIndex] [int] NULL,
[Description] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ForceDownload] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documents] ADD CONSTRAINT [PK_Documents] PRIMARY KEY NONCLUSTERED  ([ItemID]) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_Documents] ON [dbo].[Documents] ([ModuleID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documents] WITH NOCHECK ADD CONSTRAINT [FK_Documents_Modules] FOREIGN KEY ([ModuleID]) REFERENCES [dbo].[Modules] ([ModuleID]) ON DELETE CASCADE
GO
