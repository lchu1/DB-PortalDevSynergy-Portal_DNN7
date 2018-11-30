SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/* EventsRecurMasterGet */

CREATE PROCEDURE [dbo].[EventsRecurMasterGet]
(
    @RecurMasterID int,
    @ModuleID int
)
AS
BEGIN
SET NOCOUNT ON;
SET DATEFORMAT mdy;

SELECT 	RecurMasterID, 
    ModuleID, 
    PortalID,
    RRULE, 
    DTSTART,
    Duration,
    Until,
    EventName, 
    EventDesc,
    Importance,
    Notify,
    Approved,
    Signups,
    MaxEnrollment,
    (SELECT Sum(NoEnrolees) FROM dbo.[Events] AS E INNER JOIN dbo.[EventsSignups] AS S ON E.EventID = S.EventID WHERE E.RecurMasterID = R.RecurMasterID and E.Signups = 1) as Enrolled,
    EnrollRoleID,
    EnrollFee, 
    EnrollType, 
    PayPalAccount, 
    DetailPage,
    DetailNewWin,
    DetailURL,
    ImageURL, 
    ImageType, 
    ImageWidth,
    ImageHeight,
    ImageDisplay,
    Location,
    Category,
    Reminder,
    SendReminder,
    ReminderTime,
    ReminderTimeMeasurement,
    ReminderFrom,
    CustomField1,
    CustomField2,
    EnrollListView,
    DisplayEndDate,
    AllDayEvent,
    CultureName,
    OwnerID,
    CreatedByID,
    CreatedDate,
    UpdatedByID,
    UpdatedDate,
    EventTimeZoneId,
    AllowAnonEnroll,
    ContentItemId,
    SocialGroupId,
    SocialUserId,
    Summary,
    Sequence
FROM dbo.[EventsRecurMaster] R
WHERE RecurMasterID = @RecurMasterID 
  AND ModuleID = @ModuleID
END
GO
