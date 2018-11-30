SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/**** EventsGet ****/

CREATE PROCEDURE [dbo].[EventsGet]
(
    @EventID int,
    @ModuleID int
)
AS
BEGIN
SET NOCOUNT ON;
SET DATEFORMAT mdy;

CREATE Table #RealModuleID
    (EventID Int,
     ModuleID Int)


Insert into #RealModuleID (EventID, ModuleID) Select distinct e.EventID, e.ModuleID
            From dbo.[Events] e
            left outer join dbo.[EventsMaster] m ON e.ModuleID = m.SubEventID 
            WHERE EventID = @EventID  
            And (e.ModuleID =  @ModuleID Or m.ModuleID = @ModuleID)

SELECT E.PortalID, E.EventID, E.RecurMasterID, E.ModuleID, E.EventDateBegin, E.EventDateEnd,
    E.EventTimeBegin, E.Duration, E.EventName, E.EventDesc,
    E.Importance, E.CreatedDate, 
    CreatedBy = u.DisplayName,
    E.CreatedByID,
    E.Every,
    E.Period,
    E.RepeatType,
    E.Notify,
    E.Approved,
    E.Signups,
    E.MaxEnrollment,
    (Select Sum(NoEnrolees) from dbo.[EventsSignups] WHERE EventID = E.EventID and E.Signups = 1) as Enrolled,
    (Select count(*) from dbo.[Events] as E2 WHERE E2.RecurMasterID = E.RecurMasterID and E2.Cancelled = 0 and E2.Approved = 1) as NoOfRecurrences,
    (Select max(EventTimeBegin) from dbo.[Events] as E2 WHERE E2.RecurMasterID = E.RecurMasterID and E2.Cancelled = 0 and E2.Approved = 1) as LastRecurrence,
    E.EnrollRoleID,
    E.EnrollFee, 
    E.EnrollType, 
    E.PayPalAccount, 
    E.Cancelled,
    E.DetailPage,
    E.DetailNewWin,
    E.DetailURL,
    E.ImageURL, 
    E.ImageType, 
    E.ImageWidth,
    E.ImageHeight,
    E.ImageDisplay,
    E.Location,
    c.LocationName,
    c.MapURL,
    E.Category,
    b.CategoryName,
    b.Color,
    b.FontColor,
    E.Reminder,
    E.SendReminder,
    E.ReminderTime,
    E.ReminderTimeMeasurement,
    E.ReminderFrom,
    E.SearchSubmitted,
    E.CustomField1,
    E.CustomField2,
    E.EnrollListView,
    E.DisplayEndDate,
    E.AllDayEvent,
    E.OwnerID,
    OwnerName = O.DisplayName,
    E.LastUpdatedAt,
    LastUpdatedBy = L.DisplayName,
    E.LastUpdatedID,
    r.RRULE, 
    RMOwnerID = r.OwnerID,
    E.OriginalDateBegin,
    E.NewEventEmailSent,
    r.EventTimeZoneId,
    E.AllowAnonEnroll,
    E.ContentItemId,
    E.JournalItem,
    r.SocialGroupId,
    r.SocialUserId,
    E.Summary,
    E.Sequence,
    RMSequence = r.Sequence,
    SocialUserUserName = S.UserName,
    SocialUserDisplayName = S.DisplayName
FROM dbo.[Events] E
inner join dbo.[EventsRecurMaster] AS r on E.RecurMasterID = r.RecurMasterID
left outer join dbo.[Users] U on E.CreatedByID = U.UserID
left outer join dbo.[Users] O on E.OwnerID = O.UserID
left outer join dbo.[Users] L on E.LastUpdatedID = L.UserID
left outer join dbo.[Users] S on r.SocialUserId = S.UserID 
left join dbo.[EventsCategory] b on E.Category = b.Category
left join dbo.[EventsLocation] c on E.Location = c.Location
WHERE EventID = @EventID And e.ModuleID = (Select ModuleID from #RealModuleID where EventID = @EventID)
END
GO
