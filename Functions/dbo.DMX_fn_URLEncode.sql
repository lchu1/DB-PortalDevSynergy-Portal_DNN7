SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[DMX_fn_URLEncode](@String NVARCHAR(4000))
RETURNS VARCHAR(8000)
AS
BEGIN
 DECLARE @URLEncodedString VARCHAR(8000)
 SELECT @URLEncodedString=''
 SELECT @URLEncodedString=@URLEncodedString + 
  CASE WHEN theChar LIKE '[A-Za-z0-9()''*-._!/]'
   THEN theChar
   ELSE '%' + substring ('0123456789ABCDEF',(ASCII(theChar) / 16)+1,1) +  SUBSTRING('0123456789ABCDEF',(ASCII(theChar) % 16)+1,1)
  END
  FROM (SELECT [theChar]=SUBSTRING(@string,number,1)
   FROM dbo.DMX_Numbers WHERE Number <= LEN(@String)) CHARACTERARRAY
 RETURN @URLEncodedString
END
GO
