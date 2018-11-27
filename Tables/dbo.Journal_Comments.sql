CREATE TABLE [dbo].[Journal_Comments]
(
[CommentId] [int] NOT NULL IDENTITY(1, 1),
[JournalId] [int] NOT NULL,
[UserId] [int] NOT NULL,
[Comment] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateCreated] [datetime] NOT NULL,
[DateUpdated] [datetime] NOT NULL,
[CommentXML] [xml] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Journal_Comments] ADD CONSTRAINT [PK_Journal_Comments] PRIMARY KEY CLUSTERED  ([CommentId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Journal_Comments] WITH NOCHECK ADD CONSTRAINT [FK_JournalComments_Journal] FOREIGN KEY ([JournalId]) REFERENCES [dbo].[Journal] ([JournalId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Journal_Comments] NOCHECK CONSTRAINT [FK_JournalComments_Journal]
GO
