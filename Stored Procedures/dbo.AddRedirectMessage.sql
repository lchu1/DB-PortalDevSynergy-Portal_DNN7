SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[AddRedirectMessage]
	@UserId int,
	@TabId int,
	@Text [nvarchar](max)
AS
	INSERT INTO dbo.RedirectMessages
		(UserId, TabId, MessageText)
	OUTPUT inserted.MessageId
	VALUES(@UserId, @TabId, @Text)
GO
