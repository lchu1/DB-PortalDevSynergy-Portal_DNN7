CREATE TABLE [dbo].[PersonaBarMenu]
(
[MenuId] [int] NOT NULL IDENTITY(1, 1),
[Identifier] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModuleName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FolderName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Controller] [nvarchar] (260) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ResourceKey] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Path] [nvarchar] (260) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Link] [nvarchar] (260) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CssClass] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ParentId] [int] NULL,
[Order] [int] NOT NULL CONSTRAINT [DF__PersonaBa__Order__536E27D9] DEFAULT ((0)),
[AllowHost] [bit] NOT NULL CONSTRAINT [DF__PersonaBa__Allow__54624C12] DEFAULT ((0)),
[Enabled] [bit] NOT NULL CONSTRAINT [DF__PersonaBa__Enabl__5556704B] DEFAULT ((0)),
[CreatedByUserId] [int] NULL,
[CreatedOnDate] [datetime] NULL,
[LastModifiedByUserId] [int] NULL,
[LastModifiedOnDate] [datetime] NULL,
[IconFile] [nvarchar] (260) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonaBarMenu] ADD CONSTRAINT [PK_PersonaBarMenu] PRIMARY KEY CLUSTERED  ([MenuId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonaBarMenu] ADD CONSTRAINT [IX_PersonaBarMenu] UNIQUE NONCLUSTERED  ([Identifier]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonaBarMenu] ADD CONSTRAINT [FK_PersonaBarMenu_ParentId] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[PersonaBarMenu] ([MenuId])
GO
