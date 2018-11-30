SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*** EventsModerateSignups ***/
CREATE PROCEDURE [dbo].[EventsModerateSignups]
(
    @ModuleID int,
    @SocialGroupId int
)
AS
BEGIN
SET NOCOUNT ON;
SET DATEFORMAT mdy;

SELECT	s.EventID,
		s.SignupID,
		s.ModuleID,
		s.Userid,
		s.Approved,
		u.DisplayName as UserName,
		u.Email,
		c.EventDateBegin,
		c.EventTimeBegin,
		c.EventName,
		c.Importance,
		c.Approved as EventApproved,
		c.MaxEnrollment,
		(	SELECT COUNT(*)
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
     dbo.[Users] AS u ON s.UserID = u.UserID ON c.EventID = s.EventID
Where s.Approved = 0
  AND s.ModuleID = @ModuleID
  AND (r.SocialGroupId = @SocialGroupId or (r.SocialGroupId is null and @SocialGroupId = -1))
ORDER BY c.EventDateBegin, c.EventTimeBegin, c.EventName, UserName
END
GO
