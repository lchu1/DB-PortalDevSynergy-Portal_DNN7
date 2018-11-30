SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsCategoryGetByName ***/

CREATE PROCEDURE [dbo].[EventsCategoryGetByName]
    (
      @CategoryName NVARCHAR(50)
    , @PortalID INT
    )
AS 
    SELECT  Category
          , PortalID
          , CategoryName
          , Color
          , FontColor
    FROM    dbo.EventsCategory
    WHERE   CategoryName = @CategoryName
            AND PortalID = @PortalID
GO
