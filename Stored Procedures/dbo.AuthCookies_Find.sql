SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[AuthCookies_Find]
    @CookieValue  nvarchar(200)
AS
BEGIN
	SELECT TOP(1) * FROM dbo.[AuthCookies]
	WHERE CookieValue = @CookieValue
END
GO
