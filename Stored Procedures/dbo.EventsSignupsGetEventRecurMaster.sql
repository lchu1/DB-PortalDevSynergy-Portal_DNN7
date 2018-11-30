SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsSignupsGetEventRecurMaster ***/
CREATE PROCEDURE [dbo].[EventsSignupsGetEventRecurMaster]
(
    @RecurMasterID int,
    @ModuleID int
)
AS
BEGIN
SET NOCOUNT ON;
SET DATEFORMAT mdy;

SELECT DISTINCT
		s.EventID,
		s.SignupID,
		s.ModuleID,
		s.Userid,
		s.Approved,
		u.DisplayName as UserName,
		u.Email,
		c.EventTimeBegin,
		c.Duration,
		c.EventName,
		c.Importance,
		c.Approved as EventApproved,
		c.MaxEnrollment,
		(	SELECT SUM(NoEnrolees)
			FROM dbo.[EventsSignups]
			WHERE EventID = c.EventID AND c.Signups = 1
		) as Enrolled,
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
     dbo.[Events] AS c ON r.RecurMasterID = c.RecurMasterID RIGHT OUTER JOIN
     dbo.[EventsSignups] AS s LEFT OUTER JOIN
     dbo.[Users] AS u ON s.UserID = u.UserID ON c.EventID = s.EventID LEFT OUTER JOIN
     dbo.[EventsMaster] AS m ON s.ModuleID = m.SubEventID
Where  r.RecurMasterID = @RecurMasterID And
       (s.ModuleID = @ModuleID Or m.ModuleID = @ModuleID)
ORDER BY c.EventTimeBegin, c.EventName, UserName
END
GO
