SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[EventsGetByRange]
(
 @ModuleIDs nvarchar(1024),
 @BeginDate datetime,
 @EndDate datetime,
 @CategoryIDs nvarchar(1024),
 @LocationIDs nvarchar(1024),
 @SocialGroupId int,
 @SocialUserId int
)
AS
BEGIN
SET NOCOUNT ON;
SET DATEFORMAT mdy;

CREATE Table #EventIDs
    (EventID Int, NoOfRecurrences Int, LastRecurrence DateTime)

INSERT INTO #EventIDs (EventID, NoOfRecurrences, LastRecurrence) 
SELECT DISTINCT e.EventID, Count(E2.EventID) as NoOfRecurrences, Max(E2.EventTimeBegin) as LastRecurrence
 FROM dbo.[Events] E
 LEFT OUTER JOIN dbo.[EventsMaster] M ON E.ModuleID = M.SubEventID 
 LEFT JOIN dbo.[Events] as E2 ON E.RecurMasterID = E2.RecurMasterID
 WHERE ((E.EventTimeBegin < DATEADD(DAY,1,@EndDate) AND DATEADD(minute,E.Duration,E.EventTimeBegin) >=  @BeginDate) OR 
   (E.EventTimeBegin >= @BeginDate AND E.EventTimeBegin < DATEADD(DAY,1, @EndDate))) 
   AND E.Approved = 1
   AND E.Cancelled = 0
   AND (E.ModuleID in (SELECT * FROM dbo.[EventsSplitIDs](@ModuleIDs)))
GROUP By E.EventID

SELECT E.PortalID, E.EventID, E.RecurMasterID, E.ModuleID, E.EventDateBegin, E.EventDateEnd,
     E.EventTimeBegin, E.Duration, E.EventName, E.EventDesc,
     E.Importance, E.CreatedDate, 
     CreatedBy = U.DisplayName, 
     E.CreatedByID, 
     E.Every, 
     E.Period, 
     E.RepeatType, 
     E.Notify, 
     E.approved, 
     E.Signups, 
     E.MaxEnrollment, 
     (Select Sum(NoEnrolees) from dbo.[EventsSignups] WHERE EventID = E.EventID and E.Signups = 1) as Enrolled, 
     ET.NoOfRecurrences,
     ET.LastRecurrence,
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
     RMOwnerID = r.OwnerID, 
     r.RRULE, 
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
 left join #EventIDs ET on E.EventID = ET.EventID
WHERE E.EventID in (Select EventID from #EventIDs)
   AND (e.Category in (SELECT * FROM dbo.[EventsSplitIDs](@CategoryIDs)) or @CategoryIDs = '-1')
   AND (e.Location in (SELECT * FROM dbo.[EventsSplitIDs](@LocationIDs)) or @LocationIDs = '-1')
   AND (r.SocialGroupId = @SocialGroupId or @SocialGroupId = -1)
   AND (r.SocialUserId = @SocialUserId or @SocialUserId = -1)
ORDER BY e.EventTimeBegin
END
GO
