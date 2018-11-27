SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DeleteOldRedirectMessage]
	@CutoffDate [DateTime]
AS
	DELETE FROM dbo.RedirectMessages
	WHERE CreatedOnDate <= @CutoffDate
GO
