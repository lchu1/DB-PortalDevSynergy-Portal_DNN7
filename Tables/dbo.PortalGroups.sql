CREATE TABLE [dbo].[PortalGroups]
(
[PortalGroupID] [int] NOT NULL IDENTITY(1, 1),
[MasterPortalID] [int] NULL,
[PortalGroupName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PortalGroupDescription] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AuthenticationDomain] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedByUserID] [int] NULL,
[CreatedOnDate] [datetime] NULL,
[LastModifiedByUserID] [int] NULL,
[LastModifiedOnDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PortalGroups] ADD CONSTRAINT [PK_PortalGroup] PRIMARY KEY CLUSTERED  ([PortalGroupID]) ON [PRIMARY]
GO
