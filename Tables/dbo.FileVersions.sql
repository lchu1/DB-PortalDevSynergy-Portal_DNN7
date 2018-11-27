CREATE TABLE [dbo].[FileVersions]
(
[FileId] [int] NOT NULL,
[Version] [int] NOT NULL,
[FileName] [nvarchar] (246) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Extension] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Size] [int] NOT NULL,
[Width] [int] NULL,
[Height] [int] NULL,
[ContentType] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Content] [image] NULL,
[CreatedByUserID] [int] NULL,
[CreatedOnDate] [datetime] NULL,
[LastModifiedByUserID] [int] NULL,
[LastModifiedOnDate] [datetime] NULL,
[SHA1Hash] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FileVersions] ADD CONSTRAINT [PK_FileVersions] PRIMARY KEY CLUSTERED  ([FileId], [Version]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FileVersions] ADD CONSTRAINT [FK_FileVersions_Files] FOREIGN KEY ([FileId]) REFERENCES [dbo].[Files] ([FileId]) ON DELETE CASCADE
GO
