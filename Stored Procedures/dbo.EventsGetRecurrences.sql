SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsGetRecurrences ***/

CREATE PROCEDURE [dbo].[EventsGetRecurrences]
(
    @RecurMasterID int,
    @ModuleID int
)
AS
BEGIN
SET NOCOUNT ON;
SET DATEFORMAT mdy;

 SELECT E.PortalID, EventID, E.RecurMasterID, E.ModuleID, E.EventDateBegin, E.EventDateEnd,
    E.EventTimeBegin, E.Duration, E.EventName, E.EventDesc,
    E.Importance, E.CreatedDate, 
    CreatedBy = U.DisplayName,
    E.CreatedByID,
    E.Every,
    E.Period,
    E.RepeatType,
    E.Notify,
    E.Approved,
    E.Signups,
    E.MaxEnrollment,
    (Select count(*) from dbo.[EventsSignups] WHERE EventID = E.EventID and E.Signups = 1) as Enrolled,
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
  WHERE (E.RecurMasterID = @RecurMasterID AND E.ModuleID = @ModuleID) 
  ORDER BY E.EventTimeBegin, E.EventDateEnd
END
GO
