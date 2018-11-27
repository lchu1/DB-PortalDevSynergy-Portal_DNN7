SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- Adds new or Updates existing entry
CREATE PROCEDURE [dbo].[AuthCookies_Update]
    @CookieValue  nvarchar(200),
	@ExpiresOn   datetime, -- in UTC
	@UserId		  int
AS
BEGIN
	MERGE INTO dbo.[AuthCookies] AC
		USING (SELECT @CookieValue CVal, @UserId [UID], @ExpiresOn EXPDT) Q
		ON (AC.CookieValue = Q.CVal)
		WHEN MATCHED AND AC.ExpiresOn <> Q.EXPDT THEN -- update only, if there is a change, user ID shouldn't change
		UPDATE SET ExpiresOn = @ExpiresOn, UpdatedOn = GetUtcDate()
		WHEN NOT MATCHED THEN
		INSERT ( CookieValue,  UserId, ExpiresOn,  CreatedOn,    UpdatedOn )
		VALUES (@CookieValue, @UserId, @ExpiresOn, GetUtcDate(), GetUtcDate());
END
GO
