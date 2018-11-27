CREATE TABLE [dbo].[ContentWorkflowLogs]
(
[WorkflowLogID] [int] NOT NULL IDENTITY(1, 1),
[Action] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Comment] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Date] [datetime] NOT NULL,
[User] [int] NOT NULL,
[WorkflowID] [int] NOT NULL,
[ContentItemID] [int] NOT NULL,
[Type] [int] NOT NULL CONSTRAINT [DF__ContentWor__Type__0E39E7EC] DEFAULT ((-1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContentWorkflowLogs] ADD CONSTRAINT [PK_ContentWorkflowLogs] PRIMARY KEY CLUSTERED  ([WorkflowLogID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ContentWorkflowLogs_ContentItemId] ON [dbo].[ContentWorkflowLogs] ([ContentItemID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContentWorkflowLogs] ADD CONSTRAINT [FK_ContentWorkflowLogs_ContentItems] FOREIGN KEY ([ContentItemID]) REFERENCES [dbo].[ContentItems] ([ContentItemID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContentWorkflowLogs] ADD CONSTRAINT [FK_ContentWorkflowLogs_ContentWorkflows] FOREIGN KEY ([WorkflowID]) REFERENCES [dbo].[ContentWorkflows] ([WorkflowID]) ON DELETE CASCADE
GO
