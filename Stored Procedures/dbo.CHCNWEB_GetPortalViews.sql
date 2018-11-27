SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- Updated to remove hypen in the list of company IDs since we removed all hypens in UserProfile table SK.6/9/2016


CREATE  procedure [dbo].[CHCNWEB_GetPortalViews]

@StartDate datetime,
@EndDate datetime

as
DECLARE @tmp_userViews table (
		companyID varchar(100),
		company varchar(100),
		MemberSearch int,
		ClaimsSearch int,
		AuthsSearch int,
		SubmitAuth int,
		CapFiles int,
		EligDownload int,
		HPAC int,
		RemittAdvice int,
		MemRet int,
		MossAdams int,
		RebillReport int,
		SPD int,
		DocExchange int,
		Views int)
		
INSERT INTO @tmp_userViews (CompanyID, Company, MemberSearch, ClaimsSearch, AuthsSearch, SubmitAuth, CapFiles, EligDownload,
	HPAC, RemittAdvice, MemRet, MossAdams, RebillReport, SPD, DocExchange, Views)
SELECT     CC.CompanyID, CC.Company, 
           CASE WHEN MS.RoleID IS NULL THEN 0 ELSE 1 END AS MemberSearch, CASE WHEN CS.RoleID IS NULL THEN 0 ELSE 1 END AS ClaimsSearch, 
           CASE WHEN AUS.RoleID IS NULL THEN 0 ELSE 1 END AS AuthsSearch, CASE WHEN SAUS.RoleID IS NULL THEN 0 ELSE 1 END AS SubmitAuth, 
           CASE WHEN CAP.RoleID IS NULL THEN 0 ELSE 1 END AS CapFiles, CASE WHEN ELG.RoleID IS NULL THEN 0 ELSE 1 END AS EligDownload,
			CASE WHEN HPAC.RoleID IS NULL THEN 0 ELSE 1 END AS HPAC, CASE WHEN RA.RoleID IS NULL THEN 0 ELSE 1 END AS RemittAdvice,
			CASE WHEN MRF.RoleID IS NULL THEN 0 ELSE 1 END AS MemRet, CASE WHEN MA.RoleID IS NULL THEN 0 ELSE 1 END AS MossAdams,
			CASE WHEN RR.RoleID IS NULL THEN 0 ELSE 1 END AS RebillReport, CASE WHEN SPD.RoleID IS NULL THEN 0 ELSE 1 END AS SPD,
			CASE WHEN DMX.RoleID IS NULL THEN 0 ELSE 1 END AS DocExchange,
            (SELECT COUNT(UserID) AS Expr1 FROM UrlLog WHERE (UserID = U.UserID)) AS Views
FROM         Users AS U LEFT OUTER JOIN
                    UserRoles AS MS ON U.UserID = MS.UserID AND MS.RoleID = '39' LEFT OUTER JOIN /* Member Search */
					UserRoles AS CS ON U.UserID = CS.UserID AND CS.RoleID = '38' LEFT OUTER JOIN /* Claims Search */
					UserRoles AS AUS ON U.UserID = AUS.UserID AND AUS.RoleID in ('37', '41') LEFT OUTER JOIN /* AUTHs Search */
					UserRoles AS SAUS ON U.UserID = SAUS.UserID AND SAUS.RoleID = '66' LEFT OUTER JOIN /* Submit an AUTH */
					UserRoles AS CAP ON U.UserID = CAP.UserID AND CAP.RoleID in ('6', '12', '17', '26', '31', '43', '49', '50', '60', '67') LEFT OUTER JOIN /* Capitation Files */
					UserRoles AS ELG ON U.UserID = ELG.UserID AND ELG.RoleID = '57' LEFT OUTER JOIN /* Eligibility Download */
					UserRoles AS HPAC ON U.UserID = HPAC.UserID AND HPAC.RoleID in ('57', '35') LEFT OUTER JOIN /* HPAC */
					UserRoles AS RA ON U.UserID = RA.UserID AND RA.RoleID = '23' LEFT OUTER JOIN /* Remittance Advice (RA) */
					UserRoles AS MRF On U.UserID = MRF.UserID And MRF.RoleID in ('57', '35') LEFT OUTER JOIN /* Membership Retention Files */
					UserRoles AS MA ON U.UserID = MA.UserID AND MA.RoleID = '62' LEFT OUTER JOIN /* Moss Adams */
					UserRoles AS RR ON U.UserID = RR.UserID AND RR.RoleID = '23' LEFT OUTER JOIN /* Rebill Report */
					UserRoles AS SPD ON U.UserID = SPD.UserID AND SPD.RoleID in ('6', '12', '17', '26', '31', '43', '49', '53', '65') LEFT OUTER JOIN /* SPD Transition to Managed Care */
					UserRoles AS DMX ON U.UserID = DMX.UserID AND DMX.RoleID in ('19', '74', '73', '71') LEFT OUTER JOIN /* Document Exchange */					
              UserPortals AS UP ON U.UserID = UP.UserId LEFT OUTER JOIN
              _CHCN_COMPANY_VS AS CC ON U.UserID = CC.UserID 

--WHERE     (CC.CompanyID NOT IN ('CHCNCHC', '94-2232394', '94-2235908', '94-1744108', '94-2502308', '23-7135928', '23-7255435', '23-7118361', '94-1667294')) 
WHERE     (CC.CompanyID NOT IN ('CHCNCHC', '942232394', '942235908', '941744108', '942502308', '237135928', '237255435', '237118361', '941667294')) 
and      UP.CreatedDate between @StartDate and @EndDate
ORDER BY CC.CompanyID

SELECT company, 
		CASE WHEN sum(MemberSearch)=0 THEN '' ELSE 'X' END as MemberSearhc,
		CASE WHEN sum(ClaimsSearch)=0 THEN '' ELSE 'X' END as ClaimsSearch,
		CASE WHEN sum(AuthsSearch)=0 THEN '' ELSE 'X' END as AuthsSearch,
		CASE WHEN sum(SubmitAuth)=0 THEN '' ELSE 'X' END as SubmitAuth,
		CASE WHEN sum(CapFiles)=0 THEN '' ELSE 'X' END as CapFiles,
		CASE WHEN sum(EligDownload)=0 THEN '' ELSE 'X' END as EligDownload,
		CASE WHEN sum(HPAC)=0 THEN '' ELSE 'X' END as HPAC,
		CASE WHEN sum(RemittAdvice)=0 THEN '' ELSE 'X' END as RemittAdvice,
		CASE WHEN sum(MemRet)=0 THEN '' ELSE 'X' END as MemRet,
		CASE WHEN sum(MossAdams)=0 THEN '' ELSE 'X' END as MossAdams,
		CASE WHEN sum(RebillReport)=0 THEN '' ELSE 'X' END as RebillReport,
		CASE WHEN sum(SPD)=0 THEN '' ELSE 'X' END as SPD,
		CASE WHEN sum(DocExchange)=0 THEN '' ELSE 'X' END as DocExchange,
	    sum(views) as Views
FROM @tmp_userViews group by company 

GO
