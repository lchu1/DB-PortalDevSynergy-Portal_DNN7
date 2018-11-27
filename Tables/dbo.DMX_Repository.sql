CREATE TABLE [dbo].[DMX_Repository]
(
[Blob] [varbinary] (max) NULL,
[BlobId] [int] NOT NULL IDENTITY(1, 1),
[PortalId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Repository] ADD CONSTRAINT [PK_DMX_Repository] PRIMARY KEY CLUSTERED  ([BlobId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Repository] WITH NOCHECK ADD CONSTRAINT [FK_DMX_Repository_Portals] FOREIGN KEY ([PortalId]) REFERENCES [dbo].[Portals] ([PortalID]) ON DELETE CASCADE
GO
