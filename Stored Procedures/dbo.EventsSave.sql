SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/* EventsSave */

CREATE PROCEDURE [dbo].[EventsSave]
(
    @PortalID int,
    @EventID int,
    @RecurMasterID int,
    @ModuleID int,
    @EventTimeBegin datetime,
    @Duration int,
    @EventName nvarchar(100),
    @EventDesc ntext,
    @Importance int,
    @CreatedByID int,
    @Notify nvarchar(2048),
    @Approved bit,
    @Signups bit,
    @MaxEnrollment int,
    @EnrollRoleID int,
    @EnrollFee money, 
    @EnrollType varchar(10),
    @PayPalAccount nvarchar(100), 
    @Cancelled bit,
    @DetailPage bit,
    @DetailNewWin bit,
    @DetailURL nvarchar(200),
    @ImageURL nvarchar(100), 
    @ImageType varchar(1), 
    @ImageWidth int,
    @ImageHeight int,
    @ImageDisplay bit,
    @Location int,
    @Category int,
    @Reminder nvarchar(2048),
    @SendReminder bit,
    @ReminderTime int,
    @ReminderTimeMeasurement varchar(2),
    @ReminderFrom nvarchar(100),
    @SearchSubmitted bit,
    @CustomField1 nvarchar(100),
    @CustomField2 nvarchar(100),
    @EnrollListView bit,
    @DisplayEndDate bit,
    @AllDayEvent bit,
    @OwnerID int,
    @LastUpdatedID int,
    @OriginalDateBegin datetime,
    @NewEventEmailSent bit,
    @AllowAnonEnroll bit,
    @ContentItemId int,
    @JournalItem bit,
    @Summary nvarchar(max),
    @SaveOnly bit
)
AS
BEGIN
SET NOCOUNT ON;
SET DATEFORMAT mdy;

IF @Location = -1 
    Select @Location = Null

IF @Category = -1 
    Select @Category = Null

IF @EnrollRoleID = -1 
    Select @EnrollRoleID = Null

IF @ImageURL = N'' 
    Select @ImageURL = Null

IF @ImageType = '' 
    Select @ImageType = Null

IF @DetailURL = N'' 
    Select @DetailURL = Null

Declare @UTCDate datetime
Select @UTCDate = GetUTCdate()

IF @EventID = -1 OR @EventID IS NULL
    INSERT dbo.[Events]
    (
        PortalID,
        RecurMasterID,
        ModuleID,
        EventTimeBegin,
        Duration,
        EventName,
        EventDesc,
        Importance,
        CreatedByID,
        Notify,
        Approved,
        Signups,
        MaxEnrollment,
        EnrollRoleID,
        EnrollFee, 
        EnrollType, 
        PayPalAccount, 
        Cancelled,
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
        SearchSubmitted,
        CustomField1,
        CustomField2,
        EnrollListView,
        DisplayEndDate,
        AllDayEvent,
        OwnerID,
        LastUpdatedAt,
        LastUpdatedID,
        OriginalDateBegin,
        NewEventEmailSent,
        AllowAnonEnroll,
        ContentItemId,
        JournalItem,
        Summary,
        Sequence
    )
    VALUES
    (
        @PortalID,
        @RecurMasterID,
        @ModuleID,
        @EventTimeBegin,
        @Duration,
        @EventName,
        @EventDesc,
        @Importance,
        @CreatedByID,
        @Notify,
        @Approved,
        @Signups,
        @MaxEnrollment,
        @EnrollRoleID,
        @EnrollFee, 
        @EnrollType,
        @PayPalAccount, 
        @Cancelled,
        @DetailPage,
        @DetailNewWin,
        @DetailURL,
        @ImageURL, 
        @ImageType, 
        @ImageWidth,
        @ImageHeight,
        @ImageDisplay,
        @Location,
        @Category,
        @Reminder,
        @SendReminder,
        @ReminderTime,
        @ReminderTimeMeasurement,
        @ReminderFrom,
        @SearchSubmitted,
        @CustomField1,
        @CustomField2,
        @EnrollListView,
        @DisplayEndDate,
        @AllDayEvent,
        @OwnerID,
        @UTCDate,
        @LastUpdatedID,
        @OriginalDateBegin,
        @NewEventEmailSent,
        @AllowAnonEnroll,
        @ContentItemId,
        @JournalItem,
        @Summary,
        0
    )
ELSE
    BEGIN
        UPDATE dbo.[Events] SET
            PortalID = @PortalID,
            RecurMasterID = @RecurMasterID,
            EventTimeBegin = @EventTimeBegin,
            Duration = @Duration,
            EventName = @EventName,
            EventDesc = @EventDesc,
            Importance = @Importance,
            Notify = @Notify,
            Approved = @Approved,
            Signups = @Signups,
            MaxEnrollment = @MaxEnrollment,
            EnrollRoleID = @EnrollRoleID,
            EnrollFee = @EnrollFee, 
            EnrollType = @EnrollType,
            PayPalAccount = @PayPalAccount, 
            Cancelled = @Cancelled,
            DetailPage = @DetailPage,
            DetailNewWin = @DetailNewWin,
            DetailURL = @DetailURL,
            ImageURL = @ImageURL, 
            ImageType = @ImageType, 
            ImageWidth = @ImageWidth,
            ImageHeight = @ImageHeight,
            ImageDisplay = @ImageDisplay,
            Location = @Location,
            Category = @Category,
            Reminder = @Reminder,
            SendReminder = @SendReminder,
            ReminderTime = @ReminderTime,
            ReminderTimeMeasurement = @ReminderTimeMeasurement,
            ReminderFrom = @ReminderFrom,
            SearchSubmitted = @SearchSubmitted,
            CustomField1 = @CustomField1,
            CustomField2 = @CustomField2,
            EnrollListView = @EnrollListView,
            DisplayEndDate = @DisplayEndDate,
            AllDayEvent = @AllDayEvent,
            OwnerID = @OwnerID,
            LastUpdatedAt = @UTCDate,
            LastUpdatedID = @LastUpdatedID,
            OriginalDateBegin = @OriginalDateBegin,
            NewEventEmailSent = @NewEventEmailSent,
            AllowAnonEnroll = @AllowAnonEnroll,
            ContentItemId = @ContentItemId,
            JournalItem = @JournalItem,
            Summary = @Summary,
            Sequence = Sequence + 1
        WHERE EventID = @EventID And ModuleID = @ModuleID

		UPDATE  dbo.[ContentItems]
			SET     LastModifiedByUserID = @LastUpdatedID,
					LastModifiedOnDate = @UTCDate
			WHERE   ContentItemID = @ContentItemID
    END

IF @SaveOnly = 0
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
    c.Location,
    c.LocationName,
    c.MapURL,
    b.Category,
    b.CategoryName,
    b.Color,
    b.FontColor,
    E.Reminder,
    E.SendReminder,
    E.ReminderTime,
    E.ReminderTimeMeasurement,
    E.ReminderFrom,
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
WHERE EventID = scope_identity()
END
GO
