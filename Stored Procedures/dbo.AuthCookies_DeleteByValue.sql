SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[AuthCookies_DeleteByValue]
    @CookieValue  nvarchar(200)
AS
BEGIN
	DELETE FROM dbo.[AuthCookies]
	WHERE CookieValue = @CookieValue
END
GO
