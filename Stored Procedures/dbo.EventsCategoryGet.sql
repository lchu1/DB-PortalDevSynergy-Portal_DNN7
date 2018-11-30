SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsCategoryGet ***/

CREATE PROCEDURE [dbo].[EventsCategoryGet]
    (
      @Category INT
    , @PortalID INT
    )
AS 
    SELECT  Category
          , PortalID
          , CategoryName
          , Color
          , FontColor
    FROM    dbo.EventsCategory
    WHERE   Category = @Category
            AND PortalID = @PortalID
GO
