SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsCategorySave ***/

CREATE PROCEDURE [dbo].[EventsCategorySave]
    (
      @PortalID INT
    , @Category INT
    , @CategoryName NVARCHAR(50)
    , @Color VARCHAR(10)
    , @FontColor VARCHAR(10)
    )
AS 
    IF @Category = 0
        OR @Category IS NULL 
        INSERT  dbo.EventsCategory
                ( PortalID
                , CategoryName
                , Color
                , FontColor
	            )
        VALUES  ( @PortalID
                , @CategoryName
                , @Color
                , @FontColor
	            )
    ELSE 
        UPDATE  dbo.EventsCategory
        SET     CategoryName = @CategoryName
              , Color = @Color
              , FontColor = @FontColor
        WHERE   Category = @Category
                AND PortalID = @PortalID

    SELECT  Category
          , PortalID
          , CategoryName
          , Color
          , FontColor
    FROM    dbo.EventsCategory
    WHERE   Category = SCOPE_IDENTITY()
GO
