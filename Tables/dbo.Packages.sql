CREATE TABLE [dbo].[Packages]
(
[PackageID] [int] NOT NULL IDENTITY(1, 1),
[PortalID] [int] NULL,
[Name] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FriendlyName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PackageType] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Version] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[License] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Manifest] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Owner] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Organization] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Url] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReleaseNotes] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsSystemPackage] [bit] NOT NULL CONSTRAINT [DF_Packages_IsSystemPackage] DEFAULT ((0)),
[CreatedByUserID] [int] NULL,
[CreatedOnDate] [datetime] NULL,
[LastModifiedByUserID] [int] NULL,
[LastModifiedOnDate] [datetime] NULL,
[FolderName] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IconFile] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Packages] ADD CONSTRAINT [PK_Packages] PRIMARY KEY CLUSTERED  ([PackageID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Packages] ON [dbo].[Packages] ([Owner], [Name], [PackageType], [PortalID], [Version]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Packages] WITH NOCHECK ADD CONSTRAINT [FK_Packages_PackageTypes] FOREIGN KEY ([PackageType]) REFERENCES [dbo].[PackageTypes] ([PackageType]) ON DELETE CASCADE ON UPDATE CASCADE
GO
