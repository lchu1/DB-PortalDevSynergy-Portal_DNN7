CREATE TABLE [dbo].[ContentWorkflowStates]
(
[StateID] [int] NOT NULL IDENTITY(1, 1),
[WorkflowID] [int] NOT NULL,
[StateName] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order] [int] NOT NULL,
[IsActive] [bit] NOT NULL CONSTRAINT [DF_ContentWorkflowStates_IsActive] DEFAULT ((1)),
[SendEmail] [bit] NOT NULL CONSTRAINT [DF_ContentWorkflowStates_SendEmail] DEFAULT ((0)),
[SendMessage] [bit] NOT NULL CONSTRAINT [DF_ContentWorkflowStates_SendMessage] DEFAULT ((0)),
[IsDisposalState] [bit] NOT NULL CONSTRAINT [DF_ContentWorkflowStates_IsDisposalState] DEFAULT ((0)),
[OnCompleteMessageSubject] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_ContentWorkflowStates_OnCompleteMessageSubject] DEFAULT (N''),
[OnCompleteMessageBody] [nvarchar] (1024) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_ContentWorkflowStates_OnCompleteMessageBody] DEFAULT (N''),
[OnDiscardMessageSubject] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_ContentWorkflowStates_OnDiscardMessageSubject] DEFAULT (N''),
[OnDiscardMessageBody] [nvarchar] (1024) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_ContentWorkflowStates_OnDiscardMessageBody] DEFAULT (N''),
[IsSystem] [bit] NOT NULL CONSTRAINT [DF__ContentWo__IsSys__0B5D7B41] DEFAULT ((0)),
[SendNotification] [bit] NOT NULL CONSTRAINT [DF__ContentWo__SendN__0C519F7A] DEFAULT ((1)),
[SendNotificationToAdministrators] [bit] NOT NULL CONSTRAINT [DF__ContentWo__SendN__0D45C3B3] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContentWorkflowStates] ADD CONSTRAINT [PK_ContentWorkflowStates] PRIMARY KEY CLUSTERED  ([StateID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContentWorkflowStates] ADD CONSTRAINT [IX_ContentWorkflowStates] UNIQUE NONCLUSTERED  ([WorkflowID], [StateName]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContentWorkflowStates] ADD CONSTRAINT [FK_ContentWorkflowStates_ContentWorkflows] FOREIGN KEY ([WorkflowID]) REFERENCES [dbo].[ContentWorkflows] ([WorkflowID]) ON DELETE CASCADE
GO
