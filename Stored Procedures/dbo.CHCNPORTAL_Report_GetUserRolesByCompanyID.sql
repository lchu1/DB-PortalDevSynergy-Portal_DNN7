SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- =============================================
-- Author:		lchu
-- Description:	Retrieves each user roles under a given company Tax ID
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPORTAL_Report_GetUserRolesByCompanyID]

@COMPANYID VARCHAR(20)

AS

	SELECT DISTINCT U.UserID, U.Username, U.LastName, U.FirstName, U.Email,
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
			RebillReport = CASE WHEN RebillReport.RoleID IS NULL THEN '' ELSE 'X' END,
			ePDR = CASE WHEN ePDR.RoleID IS NULL THEN '' ELSE 'X' END,
			
			tester = CASE WHEN tester.RoleID IS NULL THEN '' ELSE 'X' END,

			LocalAdmin = CASE WHEN LocalAdmin.RoleID IS NULL THEN '' ELSE 'X' END,
			
			Dept_Billing = CASE WHEN DeptBilling.RoleID IS NULL THEN '' ELSE 'X' END,
			Dept_MemberServices = CASE WHEN DeptMembServices.RoleID IS NULL THEN '' ELSE 'X' END,
			Dept_AuthorizationReferral = CASE WHEN DeptAuthReferral.RoleID IS NULL THEN '' ELSE 'X' END

	FROM    Users AS U LEFT OUTER JOIN
			UserRoles Elig ON U.UserID = Elig.UserID AND Elig.RoleID =
					(SELECT RoleID FROM Roles R1 WHERE R1.RoleID=Elig.RoleID AND R1.RoleName='MSO Eligibility' AND PortalID=9) LEFT OUTER JOIN
			UserRoles Claims ON U.UserID = Claims.UserID AND Claims.RoleID =
					(SELECT RoleID FROM Roles R2 WHERE R2.RoleID=Claims.RoleID AND R2.RoleName='MSO Claims' AND PortalID=9) LEFT OUTER JOIN
			UserRoles Auths ON U.UserID = Auths.UserID AND Auths.RoleID =
					(SELECT RoleID FROM Roles R3 WHERE R3.RoleID=Auths.RoleID AND R3.RoleName='MSO Auth Search' AND PortalID=9) LEFT OUTER JOIN
			UserRoles EOB ON U.UserID = EOB.UserID AND EOB.RoleID =
					(SELECT RoleID FROM Roles R4 WHERE R4.RoleID=EOB.RoleID AND R4.RoleName='EOB Download' AND PortalID=9) LEFT OUTER JOIN
			UserRoles AuthReq ON U.UserID = AuthReq.UserID AND AuthReq.RoleID =
					(SELECT RoleID FROM Roles R5 WHERE R5.RoleID=AuthReq.RoleID AND R5.RoleName='MSO Auth Submit' AND PortalID=9) LEFT OUTER JOIN
			UserRoles LocalAdmin ON U.UserID = LocalAdmin.UserID AND LocalAdmin.RoleID =
					(SELECT RoleID FROM Roles R6 WHERE R6.RoleID=LocalAdmin.RoleID AND R6.RoleName='Local Admin') LEFT OUTER JOIN
			UserRoles CapDown ON U.UserID = CapDown.UserID AND CapDown.RoleID =
					(SELECT RoleID FROM Roles R7 WHERE R7.RoleID=CapDown.RoleID AND R7.RoleName='Capitation Download' AND PortalID=9) LEFT OUTER JOIN
			UserRoles EDown ON U.UserID = EDown.UserID AND EDown.RoleID =
					(SELECT RoleID FROM Roles R8 WHERE R8.RoleID=EDown.RoleID AND R8.RoleName='Eligibility Download' AND PortalID=9) LEFT OUTER JOIN
			UserRoles Document ON U.UserID = Document.UserID AND Document.RoleID =
					(SELECT RoleID FROM Roles R9 WHERE R9.RoleID=Document.RoleID AND R9.RoleName='Document Exchange' AND PortalID=9) LEFT OUTER JOIN
			UserRoles MemberRetention ON U.UserID = MemberRetention.UserID AND MemberRetention.RoleID =
					(SELECT RoleID FROM Roles R10 WHERE R10.RoleID=MemberRetention.RoleID AND R10.RoleName='Member Retention' AND PortalID=9) LEFT OUTER JOIN
			UserRoles RebillReport ON U.UserID = RebillReport.UserID AND RebillReport.RoleID =
					(SELECT RoleID FROM Roles R14 WHERE R14.RoleID=RebillReport.RoleID AND R14.RoleName='Rebill Report' AND PortalID=9) LEFT OUTER JOIN
			UserRoles ePDR ON U.UserID = ePDR.UserID AND ePDR.RoleID =
					(SELECT RoleID FROM Roles R15 WHERE R15.RoleID=ePDR.RoleID AND R15.RoleName='ePDR' AND PortalID=9) LEFT OUTER JOIN

			UserRoles tester ON U.UserID = tester.UserID AND tester.RoleID =
					(SELECT RoleID FROM Roles R16 WHERE R16.RoleID=tester.RoleID AND R16.RoleName='Tester' AND PortalID=9) LEFT OUTER JOIN
					
			UserRoles DeptBilling ON U.UserID = DeptBilling.UserID AND DeptBilling.RoleID =
					(SELECT RoleID FROM Roles R11 WHERE R11.RoleID=DeptBilling.RoleID AND R11.RoleName='Dept_Billing') LEFT OUTER JOIN
			UserRoles DeptMembServices ON U.UserID = DeptMembServices.UserID AND DeptMembServices.RoleID =
					(SELECT RoleID FROM Roles R12 WHERE R12.RoleID=DeptMembServices.RoleID AND R12.RoleName='Dept_MemberServices') LEFT OUTER JOIN
			UserRoles DeptAuthReferral ON U.UserID = DeptAuthReferral.UserID AND DeptAuthReferral.RoleID =
					(SELECT RoleID FROM Roles R13 WHERE R13.RoleID=DeptAuthReferral.RoleID AND R13.RoleName='Dept_AuthorizationReferral') LEFT OUTER JOIN
			UserPortals ON U.UserID = UserPortals.UserId LEFT OUTER JOIN
			_CHCN_COMPANY_VS ON U.UserID = _CHCN_COMPANY_VS.UserID 
			
	WHERE  (REPLACE(_CHCN_COMPANY_VS.CompanyID,'-','') = REPLACE(@COMPANYID,'-','')) 

	ORDER BY U.FirstName





GO
GRANT EXECUTE ON  [dbo].[CHCNPORTAL_Report_GetUserRolesByCompanyID] TO [CHCN-EB\shawnal]
GO
