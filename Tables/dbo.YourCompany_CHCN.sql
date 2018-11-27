CREATE TABLE [dbo].[YourCompany_CHCN]
(
[ModuleID] [int] NOT NULL,
[ItemID] [int] NOT NULL,
[Content] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedByUser] [int] NOT NULL,
[CreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
