SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[ConvertListToTable]
(  
	@Delimiter	NVARCHAR(5), 
    @List		NVARCHAR(MAX)
) 
RETURNS @TableOfValues TABLE 
(  
	RowNumber	SMALLINT IDENTITY(1,1), 
    RowValue	NVARCHAR(1000) 
) 
AS 
   BEGIN
      DECLARE @LenString INT 
 
      WHILE len( @List ) > 0 
         BEGIN 
         
            SELECT @LenString = 
               (CASE charindex( @Delimiter, @List ) 
                   WHEN 0 THEN len( @List ) 
                   ELSE ( charindex( @Delimiter, @List ) -1 )
                END
               ) 
                                
            INSERT INTO @TableOfValues 
               SELECT substring( @List, 1, @LenString )
                
            SELECT @List = 
               (CASE ( len( @List ) - @LenString ) 
                   WHEN 0 THEN '' 
                   ELSE right( @List, len( @List ) - @LenString - 1 ) 
                END
               ) 
         END
      RETURN 
   END
GO
