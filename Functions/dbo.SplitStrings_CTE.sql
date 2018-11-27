SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[SplitStrings_CTE]
(
   @List       NVARCHAR(MAX),
   @Delimiter  NVARCHAR(255)
)
RETURNS @Items TABLE (Item NVARCHAR(4000))
WITH SCHEMABINDING
AS
BEGIN
   DECLARE @StringLength INT = LEN(@List) + 1, @DelimiterLength INT = LEN(@Delimiter);
 
   WITH a AS
   (
       SELECT
           [start] = 1,
           [end]   = COALESCE(NULLIF(CHARINDEX(@Delimiter, 
                       @List, 1), 0), @StringLength),
           [value] = SUBSTRING(@List, 1, 
                     COALESCE(NULLIF(CHARINDEX(@Delimiter, 
                       @List, 1), 0), @StringLength) - 1)
       UNION ALL
       SELECT
           [start] = CONVERT(INT, [end]) + @DelimiterLength,
           [end]   = COALESCE(NULLIF(CHARINDEX(@Delimiter, 
                       @List, [end] + @DelimiterLength), 0), @StringLength),
           [value] = SUBSTRING(@List, [end] + @DelimiterLength, 
                     COALESCE(NULLIF(CHARINDEX(@Delimiter, 
                       @List, [end] + @DelimiterLength), 0), @StringLength)-[end]-@DelimiterLength)
       FROM a
       WHERE [end] < @StringLength
   )
   INSERT @Items SELECT [value]
   FROM a
   WHERE LEN([value]) > 0
   OPTION (MAXRECURSION 0);
 
   RETURN;
END
GO
