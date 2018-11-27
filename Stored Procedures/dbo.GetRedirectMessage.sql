SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetRedirectMessage]
	@guid [UniqueIdentifier]
AS
	SELECT MessageText
	FROM dbo.RedirectMessages
	WHERE MessageId = @guid
GO
