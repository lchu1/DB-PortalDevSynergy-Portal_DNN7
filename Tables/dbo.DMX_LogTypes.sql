CREATE TABLE [dbo].[DMX_LogTypes]
(
[LogTypeKey] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ResourceFile] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AttachFile] [bit] NULL,
[CustomSend] [bit] NULL,
[NotifyApprovers] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NotifyAudit] [bit] NULL,
[NotifyEditors] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NotifyOwner] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NotifySelf] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NotifySubscribers] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PortalId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DMX_LogTypes] ADD CONSTRAINT [PK_DMX_LogTypes] PRIMARY KEY CLUSTERED  ([LogTypeKey], [PortalId]) ON [PRIMARY]
GO
