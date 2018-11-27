CREATE TABLE [dbo].[DMX_Addons]
(
[AddonKey] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Availability] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Installed] [datetime] NULL,
[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Controller] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Features] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_Addons] ADD CONSTRAINT [PK_DMX_Addons] PRIMARY KEY CLUSTERED  ([AddonKey]) ON [PRIMARY]
GO
