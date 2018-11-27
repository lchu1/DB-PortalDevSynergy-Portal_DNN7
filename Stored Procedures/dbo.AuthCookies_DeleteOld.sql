SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[AuthCookies_DeleteOld]
	@CutoffDate   datetime -- in UTC
AS
BEGIN
	DELETE FROM dbo.[AuthCookies]
	WHERE ExpiresOn < @CutoffDate
END
GO
