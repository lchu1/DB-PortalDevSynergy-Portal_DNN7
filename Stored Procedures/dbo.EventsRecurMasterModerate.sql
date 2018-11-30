SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsRecurMasterModerate ***/

CREATE PROCEDURE [dbo].[EventsRecurMasterModerate] 
( 
    @ModuleID INT,
    @SocialGroupId INT 
)
AS 
BEGIN
SET NOCOUNT ON;
SET DATEFORMAT mdy;

SELECT  R.RecurMasterID
        , R.ModuleID
        , R.DTSTART
        , R.Until
        , R.EventName
        , MIN(E.EventID) AS FirstEventID
FROM    dbo.EventsRecurMaster AS R
        INNER JOIN dbo.Events AS E
        ON R.RecurMasterID = E.RecurMasterID
WHERE   ( R.Approved = 0 )
        AND ( R.ModuleID = @ModuleID )
        AND ( R.RRULE <> '' )
        AND ( E.Cancelled = 0 )
        AND ( E.Approved = 0 )
        AND (r.SocialGroupId = @SocialGroupId or (r.SocialGroupId is null and @SocialGroupId = -1))
GROUP BY R.RecurMasterID,
        R.ModuleID,
        R.DTSTART,
        R.Until,
        R.EventName
ORDER BY R.DTSTART
END
GO
