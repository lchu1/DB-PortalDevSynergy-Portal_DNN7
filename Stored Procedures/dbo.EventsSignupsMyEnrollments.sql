SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/** EventsSignupsMyEnrollments **/

CREATE PROCEDURE [dbo].[EventsSignupsMyEnrollments]
(
    @ModuleID int,
    @UserID int,
    @SocialGroupId int,
    @CategoryIDs as nvarchar(1024),
    @BeginDate datetime,
    @EndDate datetime
)
AS
BEGIN
SET NOCOUNT ON;
SET DATEFORMAT mdy;

Select	s.EventID,
		s.SignupID,
		s.ModuleID,
		s.Userid,
		s.Approved,
		u.displayName as UserName,
		u.Email,
		e.EventTimeBegin,
		DATEADD(mi, e.Duration, e.EventTimeBegin) as EventTimeEnd,
		e.EventName,
		e.Importance,
		e.Approved as EventApproved,
		e.MaxEnrollment,
		(Select Sum(NoEnrolees) from dbo.[EventsSignups] WHERE EventID = e.EventID and e.Signups = 1) as Enrolled,
        PayPalStatus, 
        PayPalReason, 
        PayPalTransID, 
        PayPalPayerID, 
        PayPalPayerStatus, 
        PayPalRecieverEmail, 
        PayPalUserEmail,
        PayPalPayerEmail, 
        PayPalFirstName, 
        PayPalLastName, 
        PayPalAddress, 
        PayPalCity, 
        PayPalState, 
        PayPalZip, 
        PayPalCountry, 
        PayPalCurrency, 
        PayPalPaymentDate, 
        PayPalAmount, 
        PayPalFee,
        NoEnrolees,
        r.EventTimeZoneId,
        AnonEmail,
        AnonName,
        AnonTelephone,
        AnonCulture,
        AnonTimeZoneId,
		S.FirstName,
		S.LastName,
		S.Company,
		S.JobTitle,
		S.ReferenceNumber,
		S.Street,
		S.PostalCode,
		S.City,
		S.Region,
		S.Country
FROM dbo.[EventsRecurMaster] AS r RIGHT OUTER JOIN
     dbo.[Events] AS e ON r.RecurMasterID = e.RecurMasterID RIGHT OUTER JOIN
     dbo.[EventsSignups] AS s LEFT OUTER JOIN
     dbo.[Users] AS u ON s.UserID = u.UserID ON e.EventID = s.EventID LEFT OUTER JOIN
     dbo.[EventsMaster] AS M ON s.ModuleID = M.SubEventID
Where  s.Userid = @UserID AND (s.ModuleID = @ModuleID Or M.ModuleID = @ModuleID)
  AND (r.SocialGroupId = @SocialGroupId or (r.SocialGroupId is null and @SocialGroupId = -1))
  AND (e.Category in (SELECT * FROM dbo.[EventsSplitIDs](@CategoryIDs)) or @CategoryIDs = '-1')
  AND ((e.EventTimeBegin < DATEADD(DAY,1,@EndDate) AND DATEADD(minute,e.Duration,e.EventTimeBegin) >=  @BeginDate) OR 
   (e.EventTimeBegin >= @BeginDate AND e.EventTimeBegin < DATEADD(DAY,1, @EndDate))) 
ORDER BY e.EventTimeBegin desc
END
GO
