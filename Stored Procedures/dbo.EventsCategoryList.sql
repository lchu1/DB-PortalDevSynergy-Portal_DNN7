SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsCategoryList ***/

CREATE PROCEDURE [dbo].[EventsCategoryList] ( @PortalID INT )
AS 
    SELECT  Category
          , PortalID
          , CategoryName
          , Color
          , FontColor
    FROM    dbo.EventsCategory
    WHERE   PortalID = @PortalID
    ORDER BY CategoryName
GO
