CREATE TABLE [dbo].[PackageTypes]
(
[PackageType] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SecurityAccessLevel] [int] NOT NULL,
[EditorControlSrc] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SupportsSideBySideInstallation] [bit] NOT NULL CONSTRAINT [DF__PackageTy__Suppo__5B196B42] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PackageTypes] ADD CONSTRAINT [PK_PackageTypes_1] PRIMARY KEY CLUSTERED  ([PackageType]) ON [PRIMARY]
GO
