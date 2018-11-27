SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Journal_Comment_Save]
	@JournalId int,
	@CommentId int,
	@UserId int,
	@Comment nvarchar(max),
	@CommentXML xml,
	@DateUpdated datetime
AS

DECLARE @cxml xml
DECLARE @xml xml
DECLARE @cdataComment nvarchar(max)

IF EXISTS(SELECT * FROM dbo.[Journal_Comments] WHERE JournalId = @JournalId AND CommentId = @CommentId)
BEGIN
	IF (LEN(@Comment) < 2000)
	BEGIN
		UPDATE dbo.[Journal_Comments]
		SET Comment = @Comment,
			CommentXML = @CommentXML,
			DateUpdated = IsNull(@DateUpdated, GETUTCDATE())
		WHERE JournalId = @JournalId AND CommentId = @CommentId
	END
	ELSE
	BEGIN		
		IF @CommentXML IS NULL
			SET @cxml = '<root></root>';
		ELSE
			SET @cxml = @CommentXML

		IF NOT(@cxml.exist('/root/comment') = 1)
			SET @cxml.modify('insert <comment>NULL</comment> as last into (/root)[1]') 

		SET @cdataComment = '<![CDATA[' + @Comment + ']]>'
		SET @cxml.modify('replace value of (/root/comment[1]/text())[1] with sql:variable("@cdataComment")')
		
		UPDATE dbo.[Journal_Comments]
		SET CommentXML = @cxml,
			Comment = NULL,
			DateUpdated = IsNull(@DateUpdated, GETUTCDATE())
		WHERE JournalId = @JournalId AND CommentId = @CommentId
	END
END
ELSE
BEGIN
	IF (LEN(@Comment) < 2000)
	BEGIN
		INSERT INTO dbo.[Journal_Comments]
			(JournalId, UserId, Comment, CommentXML, DateCreated, DateUpdated)
			VALUES
			(@JournalId, @UserId, @Comment, @CommentXML, GETUTCDATE(), GETUTCDATE())
		SET @CommentId = SCOPE_IDENTITY()
	END
	ELSE
	BEGIN
		IF @CommentXML IS NULL
			SET @cxml = '<root></root>';
		ELSE
			SET @cxml = @CommentXML

		IF NOT(@cxml.exist('/root/comment') = 1)
			SET @cxml.modify('insert <comment>NULL</comment> as last into (/root)[1]') 

		SET @cdataComment = '<![CDATA[' + @Comment + ']]>'
		SET @cxml.modify('replace value of (/root/comment[1]/text())[1] with sql:variable("@cdataComment")')
		
		INSERT INTO dbo.[Journal_Comments]
			(JournalId, UserId, Comment, CommentXML, DateCreated, DateUpdated)
			VALUES
			(@JournalId, @UserId, NULL, @cxml, GETUTCDATE(), GETUTCDATE())
		SET @CommentId = SCOPE_IDENTITY()
	END		
END
SELECT @CommentId
GO
