SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/** SplitIDs Function **/

CREATE FUNCTION [dbo].[EventsSplitIDs]
    (
      @RecordIDList VARCHAR(1024)
    )
RETURNS @ParsedList TABLE ( RecordID INT )
AS 
    BEGIN
        DECLARE @RecordID VARCHAR(10)
          , @Pos INT

        SET @RecordIDList = LTRIM(RTRIM(@RecordIDList)) + ','
        SET @Pos = CHARINDEX(',', @RecordIDList, 1)

        IF REPLACE(@RecordIDList, ',', '') <> '' 
            BEGIN
                WHILE @Pos > 0 
                    BEGIN
                        SET @RecordID = LTRIM(RTRIM(LEFT(@RecordIDList,
                                                         @Pos - 1)))
                        IF @RecordID <> '' 
                            BEGIN
                                INSERT  INTO @ParsedList
                                        ( RecordID )
                                VALUES  ( CAST(@RecordID AS INT) ) --Use Appropriate conversion
                            END
                        SET @RecordIDList = RIGHT(@RecordIDList,
                                                  LEN(@RecordIDList) - @Pos)
                        SET @Pos = CHARINDEX(',', @RecordIDList, 1)

                    END
            END	
        RETURN
    END
GO
