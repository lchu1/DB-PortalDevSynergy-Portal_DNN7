CREATE TABLE [dbo].[PersonaBarExtensions]
(
[ExtensionId] [int] NOT NULL IDENTITY(1, 1),
[Identifier] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MenuId] [int] NOT NULL,
[FolderName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Controller] [nvarchar] (260) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Container] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Path] [nvarchar] (260) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order] [int] NOT NULL CONSTRAINT [DF__PersonaBa__Order__5CF79213] DEFAULT ((0)),
[Enabled] [bit] NOT NULL CONSTRAINT [DF__PersonaBa__Enabl__5DEBB64C] DEFAULT ((1)),
[CreatedByUserId] [int] NULL,
[CreatedOnDate] [datetime] NULL,
[LastModifiedByUserId] [int] NULL,
[LastModifiedOnDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonaBarExtensions] ADD CONSTRAINT [PK_PersonaBarExtensions] PRIMARY KEY CLUSTERED  ([ExtensionId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonaBarExtensions] ADD CONSTRAINT [IX_PersonaBarExtensions] UNIQUE NONCLUSTERED  ([Identifier]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonaBarExtensions] ADD CONSTRAINT [FK_PersonaBarExtensions_MenuId] FOREIGN KEY ([MenuId]) REFERENCES [dbo].[PersonaBarMenu] ([MenuId]) ON DELETE CASCADE
GO
