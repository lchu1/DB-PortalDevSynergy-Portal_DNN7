SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[fn_ParseVersion]
(
	@Version	nvarchar(20)
)
RETURNS @VersionParts TABLE (Major int, Minor int, Build int)
WITH SCHEMABINDING
AS
	BEGIN
		DECLARE @Pos int;
		DECLARE @String nvarchar(20);
		DECLARE @Major int;
		DECLARE @Minor int;
		DECLARE @Build int;

		SET @String = @Version;
		SET @Pos = CHARINDEX('.' , @String);
		SET @Major = CONVERT(int, LEFT(@String, @Pos - 1));
		SET @String = STUFF(@String, 1, @Pos, '');
		SET @Pos = CHARINDEX('.' , @String);
		SET @Minor = CONVERT(int, LEFT(@String, @Pos - 1));
		SET @String = STUFF(@String, 1, @Pos, '');
		SET @Build = CONVERT(int, @String);

		INSERT INTO @VersionParts(Major, Minor, Build)
		VALUES (@Major, @Minor, @Build);

		RETURN;
	END
GO
