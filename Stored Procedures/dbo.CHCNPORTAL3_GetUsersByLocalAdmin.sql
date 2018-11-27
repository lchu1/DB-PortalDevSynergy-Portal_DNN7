SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- Stripping out hyphens from COMPANYID comparison SK.5/17/2016
-- Added whitespace trimming to COMPANYID SYNERGY.10/03/2016

CREATE  PROCEDURE [dbo].[CHCNPORTAL3_GetUsersByLocalAdmin]
@COMPANYID VARCHAR(20),
@LocalAdminUserID VARCHAR(10),
@PortalID INT
AS

declare @LocalAdminNPI varchar(10)

set @LocalAdminNPI = (SELECT PropertyValue FROM [Portal_DNN7].[dbo].[UserProfile] UP, [Portal_DNN7].[dbo].[ProfilePropertyDefinition] PPD WHERE UP.PropertyDefinitionID=PPD.PropertyDefinitionID and PropertyName='CompanyNPI1' and UP.UserID=@LocalAdminUserID)

IF @LocalAdminNPI IS NULL OR @LocalAdminNPI = '' -- local admin has no NPI
	BEGIN
	-- retrieve users by department only
	SELECT distinct U.UserID, U.Username, U.LastName, U.FirstName, U.Email,
			CONVERT(char(10),UserPortals.CreatedDate,101) AS CreateDate,
			Authorized = CASE WHEN UserPortals.Authorised = '1' THEN 'X' ELSE '' END,
			Claims = CASE WHEN Claims.RoleID is null THEN '' ELSE 'X' END,
			Auths = CASE WHEN Auths.RoleID is null THEN '' ELSE 'X' END,
			Elig = CASE WHEN Elig.RoleID is null THEN '' ELSE 'X' END,
			EOB = CASE WHEN EOB.RoleID is null THEN '' ELSE 'X' END,
			AuthReq = CASE WHEN AuthReq.RoleID is null THEN '' ELSE 'X' END,
			Cap = CASE WHEN CapDown.RoleID is null THEN '' ELSE 'X' END,
			EligDownload = CASE WHEN Edown.RoleID is null THEN '' ELSE 'X' END,
			Document = CASE WHEN Document.RoleID is null THEN '' ELSE 'X' END,
			MemberRetention = CASE WHEN MemberRetention.RoleID is null THEN '' ELSE 'X' END,
			Disputes = CASE WHEN Disputes.RoleID is null THEN '' ELSE 'X' END,
			RebillReport = CASE WHEN RebillReport.RoleID is null THEN '' ELSE 'X' END,

			Dept_Billing = CASE WHEN DeptBilling.RoleID is null THEN '' ELSE 'X' END,
			Dept_MemberServices = CASE WHEN DeptMembServices.RoleID is null THEN '' ELSE 'X' END,
			Dept_AuthorizationReferral = CASE WHEN DeptAuthReferral.RoleID is null THEN '' ELSE 'X' END,

			isLockedOut = CASE WHEN ASP_M.IsLockedOut = '1' THEN 'X' ELSE '' END

	FROM    Users as U LEFT OUTER JOIN
			UserRoles Elig ON U.UserID = Elig.UserID AND Elig.RoleID =
					(SELECT RoleID from Roles R1 WHERE R1.RoleID=Elig.RoleID and R1.RoleName='MSO Eligibility' and PortalID=@PortalID) LEFT OUTER JOIN
			UserRoles Claims ON U.UserID = Claims.UserID AND Claims.RoleID =
					(SELECT RoleID from Roles R2 WHERE R2.RoleID=Claims.RoleID and R2.RoleName='MSO Claims' and PortalID=@PortalID) LEFT OUTER JOIN
			UserRoles Auths ON U.UserID = Auths.UserID AND Auths.RoleID =
					(SELECT RoleID from Roles R3 WHERE R3.RoleID=Auths.RoleID and R3.RoleName='MSO Auth Search' and PortalID=@PortalID) LEFT OUTER JOIN
			UserRoles EOB ON U.UserID = EOB.UserID AND EOB.RoleID =
					(SELECT RoleID from Roles R4 WHERE R4.RoleID=EOB.RoleID and R4.RoleName='EOB Download' and PortalID=@PortalID) LEFT OUTER JOIN
			UserRoles AuthReq ON U.UserID = AuthReq.UserID AND AuthReq.RoleID =
					(SELECT RoleID from Roles R5 WHERE R5.RoleID=AuthReq.RoleID and R5.RoleName='MSO Auth Submit' and PortalID=@PortalID) LEFT OUTER JOIN
			UserRoles LocalAdmin ON U.UserID = LocalAdmin.UserID AND LocalAdmin.RoleID =
					(SELECT RoleID from Roles R6 WHERE R6.RoleID=LocalAdmin.RoleID and R6.RoleName='Local Admin') LEFT OUTER JOIN
			UserRoles CapDown ON U.UserID = CapDown.UserID AND CapDown.RoleID =
					(SELECT RoleID from Roles R7 WHERE R7.RoleID=CapDown.RoleID and R7.RoleName='Capitation Download' and PortalID=@PortalID) LEFT OUTER JOIN
			UserRoles EDown ON U.UserID = EDown.UserID AND EDown.RoleID =
					(SELECT RoleID from Roles R8 WHERE R8.RoleID=EDown.RoleID and R8.RoleName='Eligibility Download' and PortalID=@PortalID) LEFT OUTER JOIN
			UserRoles Document ON U.UserID = Document.UserID AND Document.RoleID =
					(SELECT RoleID from Roles R9 WHERE R9.RoleID=Document.RoleID and R9.RoleName='Document Exchange' and PortalID=@PortalID) LEFT OUTER JOIN
			UserRoles MemberRetention ON U.UserID = MemberRetention.UserID AND MemberRetention.RoleID =
					(SELECT RoleID from Roles R10 WHERE R10.RoleID=MemberRetention.RoleID and R10.RoleName='Member Retention' and PortalID=@PortalID) LEFT OUTER JOIN
			UserRoles Disputes ON U.UserID = Disputes.UserID AND Disputes.RoleID =
					(SELECT RoleID from Roles R10 WHERE R10.RoleID=Disputes.RoleID and R10.RoleName='ePDR' and PortalID=@PortalID) LEFT OUTER JOIN
			UserRoles RebillReport ON U.UserID = RebillReport.UserID AND RebillReport.RoleID =
					(SELECT RoleID from Roles R11 WHERE R11.RoleID=RebillReport.RoleID and R11.RoleName='Rebill Report' and PortalID=@PortalID) LEFT OUTER JOIN

			UserRoles DeptBilling ON U.UserID = DeptBilling.UserID AND DeptBilling.RoleID =
					(SELECT RoleID from Roles R11 WHERE R11.RoleID=DeptBilling.RoleID and R11.RoleName='Dept_Billing') LEFT OUTER JOIN
			UserRoles DeptMembServices ON U.UserID = DeptMembServices.UserID AND DeptMembServices.RoleID =
					(SELECT RoleID from Roles R12 WHERE R12.RoleID=DeptMembServices.RoleID and R12.RoleName='Dept_MemberServices') LEFT OUTER JOIN
			UserRoles DeptAuthReferral ON U.UserID = DeptAuthReferral.UserID AND DeptAuthReferral.RoleID =
					(SELECT RoleID from Roles R13 WHERE R13.RoleID=DeptAuthReferral.RoleID and R13.RoleName='Dept_AuthorizationReferral') LEFT OUTER JOIN
			UserPortals ON U.UserID = UserPortals.UserId LEFT OUTER JOIN
			_CHCN_COMPANY_VS ON U.UserID = _CHCN_COMPANY_VS.UserID LEFT OUTER JOIN
			UserRoles Dept ON U.UserID = Dept.UserId LEFT OUTER JOIN
			[dbo].[aspnet_Users] ASP_U ON LOWER(U.Username) = ASP_U.LoweredUserName LEFT OUTER JOIN
			[dbo].[aspnet_Membership] ASP_M ON LOWER(U.Email) = ASP_M.LoweredEmail  AND ASP_M.UserId = ASP_U.UserId
	WHERE  (REPLACE(_CHCN_COMPANY_VS.CompanyID,'-','') = REPLACE(@COMPANYID,'-','')) AND LocalAdmin.RoleID is null
				and Dept.RoleID in ( 	SELECT R.RoleID
										FROM	[Portal_DNN7].[dbo].[Users] U,
												[Portal_DNN7].[dbo].[UserRoles] UR,
												[Portal_DNN7].[dbo].[Roles] R
										Where U.UserID=UR.UserID and UR.RoleID=R.RoleID
												and R.RoleName in ('Dept_MemberServices', 'Dept_AuthorizationReferral', 'Dept_Billing')
												and U.UserID=@LocalAdminUserID)
	ORDER BY U.FirstName
	END
ELSE
	BEGIN
		SELECT DISTINCT Users.UserID, Users.Username, Users.LastName, Users.FirstName, Users.Email,
			CONVERT(CHAR(10),UserPortals.CreatedDate,101) AS CreateDate,
			Authorized = CASE WHEN UserPortals.Authorised = '1' THEN 'X' ELSE '' END,
			Claims = CASE WHEN Claims.RoleID IS NULL THEN '' ELSE 'X' END,
			Auths = CASE WHEN Auths.RoleID IS NULL THEN '' ELSE 'X' END,
			Elig = CASE WHEN Elig.RoleID IS NULL THEN '' ELSE 'X' END,
			EOB = CASE WHEN EOB.RoleID IS NULL THEN '' ELSE 'X' END,
			AuthReq = CASE WHEN AuthReq.RoleID IS NULL THEN '' ELSE 'X' END,
			Cap = CASE WHEN CapDown.RoleID IS NULL THEN '' ELSE 'X' END,
			EligDownload = CASE WHEN Edown.RoleID IS NULL THEN '' ELSE 'X' END,
			Document = CASE WHEN Document.RoleID IS NULL THEN '' ELSE 'X' END,
			MemberRetention = CASE WHEN MemberRetention.RoleID IS NULL THEN '' ELSE 'X' END,
			Disputes = CASE WHEN Disputes.RoleID is null THEN '' ELSE 'X' END,
			RebillReport = CASE WHEN RebillReport.RoleID IS NULL THEN '' ELSE 'X' END,

			Dept_Billing = CASE WHEN DeptBilling.RoleID IS NULL THEN '' ELSE 'X' END,
			Dept_MemberServices = CASE WHEN DeptMembServices.RoleID IS NULL THEN '' ELSE 'X' END,
			Dept_AuthorizationReferral = CASE WHEN DeptAuthReferral.RoleID IS NULL THEN '' ELSE 'X' END,

			isLockedOut = CASE WHEN ASP_M.IsLockedOut = '1' THEN 'X' ELSE '' END

		FROM    Users LEFT OUTER JOIN
				UserRoles Elig ON Users.UserID = Elig.UserID AND Elig.RoleID =
						(SELECT RoleID FROM Roles R1 WHERE R1.RoleID=Elig.RoleID AND R1.RoleName='MSO Eligibility' AND PortalID=@PortalID) LEFT OUTER JOIN
				UserRoles Claims ON Users.UserID = Claims.UserID AND Claims.RoleID =
						(SELECT RoleID FROM Roles R2 WHERE R2.RoleID=Claims.RoleID AND R2.RoleName='MSO Claims' AND PortalID=@PortalID) LEFT OUTER JOIN
				UserRoles Auths ON Users.UserID = Auths.UserID AND Auths.RoleID =
						(SELECT RoleID FROM Roles R3 WHERE R3.RoleID=Auths.RoleID AND R3.RoleName='MSO Auth Search' AND PortalID=@PortalID) LEFT OUTER JOIN
				UserRoles EOB ON Users.UserID = EOB.UserID AND EOB.RoleID =
						(SELECT RoleID FROM Roles R4 WHERE R4.RoleID=EOB.RoleID AND R4.RoleName='EOB Download' AND PortalID=@PortalID) LEFT OUTER JOIN
				UserRoles AuthReq ON Users.UserID = AuthReq.UserID AND AuthReq.RoleID =
						(SELECT RoleID FROM Roles R5 WHERE R5.RoleID=AuthReq.RoleID AND R5.RoleName='MSO Auth Submit' AND PortalID=@PortalID) LEFT OUTER JOIN
				UserRoles LocalAdmin ON Users.UserID = LocalAdmin.UserID AND LocalAdmin.RoleID =
						(SELECT RoleID FROM Roles R6 WHERE R6.RoleID=LocalAdmin.RoleID AND R6.RoleName='Local Admin' AND PortalID=@PortalID) LEFT OUTER JOIN
				UserRoles CapDown ON Users.UserID = CapDown.UserID AND CapDown.RoleID =
						(SELECT RoleID FROM Roles R7 WHERE R7.RoleID=CapDown.RoleID AND R7.RoleName='Capitation Download' AND PortalID=@PortalID) LEFT OUTER JOIN
				UserRoles EDown ON Users.UserID = EDown.UserID AND EDown.RoleID =
						(SELECT RoleID FROM Roles R8 WHERE R8.RoleID=EDown.RoleID AND R8.RoleName='Eligibility Download' AND PortalID=@PortalID) LEFT OUTER JOIN
				UserRoles Document ON Users.UserID = Document.UserID AND Document.RoleID =
						(SELECT RoleID FROM Roles R9 WHERE R9.RoleID=Document.RoleID AND R9.RoleName='Document Exchange' AND PortalID=@PortalID) LEFT OUTER JOIN
				UserRoles MemberRetention ON Users.UserID = MemberRetention.UserID AND MemberRetention.RoleID =
						(SELECT RoleID FROM Roles R10 WHERE R10.RoleID=MemberRetention.RoleID AND R10.RoleName='Member Retention' AND PortalID=@PortalID) LEFT OUTER JOIN
				
				UserRoles Disputes ON Users.UserID = Disputes.UserID AND Disputes.RoleID =
					(SELECT RoleID from Roles R10 WHERE R10.RoleID=Disputes.RoleID and R10.RoleName='ePDR' and PortalID=@PortalID) LEFT OUTER JOIN

				UserRoles RebillReport ON Users.UserID = RebillReport.UserID AND RebillReport.RoleID =
					(SELECT RoleID FROM Roles R11 WHERE R11.RoleID=RebillReport.RoleID AND R11.RoleName='Rebill Report' AND PortalID=@PortalID) LEFT OUTER JOIN

				UserRoles DeptBilling ON Users.UserID = DeptBilling.UserID AND DeptBilling.RoleID =
					(SELECT RoleID FROM Roles R11 WHERE R11.RoleID=DeptBilling.RoleID AND R11.RoleName='Dept_Billing') LEFT OUTER JOIN
				UserRoles DeptMembServices ON Users.UserID = DeptMembServices.UserID AND DeptMembServices.RoleID =
					(SELECT RoleID FROM Roles R12 WHERE R12.RoleID=DeptMembServices.RoleID AND R12.RoleName='Dept_MemberServices') LEFT OUTER JOIN
				UserRoles DeptAuthReferral ON Users.UserID = DeptAuthReferral.UserID AND DeptAuthReferral.RoleID =
					(SELECT RoleID FROM Roles R13 WHERE R13.RoleID=DeptAuthReferral.RoleID AND R13.RoleName='Dept_AuthorizationReferral') LEFT OUTER JOIN

				UserPortals ON Users.UserID = UserPortals.UserId LEFT OUTER JOIN
				_CHCN_COMPANY_VS ON Users.UserID = _CHCN_COMPANY_VS.UserID LEFT OUTER JOIN
				UserProfile ON Users.UserID=UserProfile.UserID LEFT OUTER JOIN
				ProfilePropertyDefinition PPD ON UserProfile.PropertyDefinitionID = PPD.PropertyDefinitionID LEFT OUTER JOIN
				[dbo].[aspnet_Users] ASP_U ON LOWER(Users.Username) = ASP_U.LoweredUserName LEFT OUTER JOIN
				[dbo].[aspnet_Membership] ASP_M ON LOWER(Users.Email) = ASP_M.LoweredEmail  AND ASP_M.UserId = ASP_U.UserId
		WHERE     (REPLACE(_CHCN_COMPANY_VS.CompanyID,'-','') = REPLACE(@COMPANYID,'-','')) AND LocalAdmin.RoleID IS NULL
				  AND PPD.PropertyName='CompanyNPI1' AND UserProfile.PropertyValue = @LocalAdminNPI
		ORDER BY Users.FirstName
	END

GO
