SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/* EventsRecurMasterSave */

CREATE PROCEDURE [dbo].[EventsRecurMasterSave]
(
    @RecurMasterID int,
    @ModuleID int,
    @PortalID int,
    @RRULE nvarchar(1000),
    @DTSTART datetime,
    @Duration nvarchar(50),
    @Until datetime,
    @EventName nvarchar(100),
    @EventDesc ntext,
    @Importance int,
    @Notify nvarchar(2048),
    @Approved bit,
    @Signups bit,
    @MaxEnrollment int,
    @EnrollRoleID int,
    @EnrollFee money, 
    @EnrollType varchar(10),
    @PayPalAccount nvarchar(100), 
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
    @CustomField1 nvarchar(100),
    @CustomField2 nvarchar(100),
    @EnrollListView bit,
    @DisplayEndDate bit,
    @AllDayEvent bit,
    @CultureName varchar(10),
    @OwnerID int,
    @CreatedByID int,
    @UpdatedByID int,
    @EventTimeZoneId nvarchar(100),
    @AllowAnonEnroll bit,
    @ContentItemId int,
    @SocialGroupId Int,
    @SocialUserId int,
    @Summary nvarchar(max)
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

If @SocialGroupId = 0
    Select @SocialGroupId = Null

If @SocialGroupId = -1
    Select @SocialGroupId = Null

If @SocialUserId = 0
    Select @SocialUserId = Null

If @SocialUserId = -1
    Select @SocialUserId = Null

IF @ImageURL = N'' 
    Select @ImageURL = Null

IF @ImageType = '' 
    Select @ImageType = Null

IF @DetailURL = N'' 
    Select @DetailURL = Null

Declare @UTCDate DateTime
Select @UTCDate = GetUTCDate()

IF @RecurMasterID = -1 OR @recurMasterID IS NULL
    INSERT dbo.[EventsRecurMaster]
    (
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
    )
    VALUES
    (
        @ModuleID,
        @PortalID,
        @RRULE,
        @DTSTART,
        @Duration,
        @Until,
        @EventName,
        @EventDesc,
        @Importance,
        @Notify,
        @Approved,
        @Signups,
        @MaxEnrollment,
        @EnrollRoleID,
        @EnrollFee, 
        @EnrollType,
        @PayPalAccount, 
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
        @CustomField1,
        @CustomField2,
        @EnrollListView,
        @DisplayEndDate,
        @AllDayEvent,
        @CultureName,
        @OwnerID,
        @CreatedByID,
        GetUTCDate(),
        @UpdatedByID,
        @UTCDate,
        @EventTimeZoneId,
        @AllowAnonEnroll,
        @ContentItemId,
        @SocialGroupId,
        @SocialUserId,
        @Summary,
        0
    )
ELSE
    BEGIN
        UPDATE dbo.[EventsRecurMaster] SET
            RRULE = @RRULE,
            DTSTART = @DTSTART,
            Duration = @Duration,
            Until = @Until,
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
            CustomField1 = @CustomField1,
            CustomField2 = @CustomField2,
            EnrollListView = @EnrollListView,
            DisplayEndDate = @DisplayEndDate,
            AllDayEvent = @AllDayEvent,
            CultureName = @CultureName,
            OwnerID = @OwnerID,
            UpdatedByID = @UpdatedByID,
            UpdatedDate = @UTCDate,
            EventTimeZoneId = @EventTimeZoneId,
            AllowAnonEnroll = @AllowAnonEnroll,
            ContentItemId = @ContentItemId,
            SocialGroupId = @SocialGroupId,
            SocialUserId = @SocialUserId,
            Summary = @Summary,
            Sequence = Sequence + 1
        WHERE RecurMasterID = @RecurMasterID And ModuleID = @ModuleID

   		UPDATE  dbo.[ContentItems]
			SET     LastModifiedByUserID = @UpdatedByID,
					LastModifiedOnDate = @UTCDate
			WHERE   ContentItemID = @ContentItemID

    END
      
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
    (SELECT COUNT(*) FROM dbo.[Events] AS E INNER JOIN dbo.[EventsSignups] AS S ON E.EventID = S.EventID WHERE E.RecurMasterID = R.RecurMasterID and E.Signups = 1) as Enrolled,
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
WHERE RecurMasterID = scope_identity() or RecurMasterID = @RecurMasterID
END
GO
