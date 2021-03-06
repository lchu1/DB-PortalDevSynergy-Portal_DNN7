SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[DMX_fn_GetExtension]
 (@Filename NVARCHAR(200))
RETURNS NVARCHAR(10)
AS
BEGIN
 IF @Filename IS NOT NULL
  IF @Filename<>''
   DECLARE @POS INT
   SELECT @POS = LEN(@Filename)-1
   DECLARE @CHR NVARCHAR(1)
   SELECT @CHR = SUBSTRING(@Filename,@POS,1)
   WHILE @CHR<>'.' AND @POS>1
   BEGIN
    SELECT @POS = @POS-1
    SELECT @CHR = SUBSTRING(@Filename,@POS,1)
   END
   IF @POS > 1
    RETURN SUBSTRING(@Filename,@POS,LEN(@Filename)-@POS+1)
 RETURN ''
END
GO
