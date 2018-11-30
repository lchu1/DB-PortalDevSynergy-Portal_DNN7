SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsModerateEvents ***/

CREATE PROCEDURE [dbo].[EventsModerateEvents]
(
    @ModuleID int,
    @SocialGroupId int
)
AS
BEGIN
SET NOCOUNT ON;
SET DATEFORMAT mdy;

SELECT E.EventID, E.ModuleID, E.EventDateBegin, E.EventDateEnd,
    E.EventTimeBegin, E.Duration, E.EventName, E.EventDesc,
    E.Importance, E.CreatedDate, 
    CreatedBy = U.DisplayName,
    E.CreatedByID,
    E.Every,
    E.Period,
    E.RepeatType,
    E.Notify,
    E.Approved,
    E.MaxEnrollment,
    (Select count(*) from dbo.[EventsSignups] WHERE EventID = E.EventID and E.Signups = 1) as Enrolled,
    E.EnrollRoleID,
    E.EnrollFee, 
    E.EnrollType, 
    E.PayPalAccount, 
    E.Cancelled,
    r.EventTimeZoneId
FROM dbo.Events AS E LEFT OUTER JOIN
     dbo.EventsRecurMaster AS r ON E.RecurMasterID = r.RecurMasterID LEFT OUTER JOIN
     dbo.Users AS U ON E.CreatedByID = U.UserID
WHERE E.Approved = 0
    AND E.ModuleID = @ModuleID AND E.Cancelled = 0 
    AND (r.SocialGroupId = @SocialGroupId or (r.SocialGroupId is null and @SocialGroupId = -1))
ORDER BY E.EventTimeBegin

END
GO
