SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










-- Updated to remove hypen in the list of company IDs since we removed all hypens in UserProfile table SK.6/9/2016



CREATE procedure [dbo].[CHCNWEB_GetUsers_Providers_Manual]

@StartDate datetime,
@EndDate datetime

as



SELECT     CC.CompanyID, CC.Company, U.LastName, U.FirstName, U.Email, CONVERT(char(10), UP.CreatedDate, 101) AS CreateDate, CONVERT(char(10), 
                      ASP.LastActivityDate, 101) AS LastLoginDate, CASE WHEN UP.Authorised = '1' THEN 'YES' ELSE 'NO' END AS Authorized, 
                      CASE WHEN CL.RoleID IS NULL THEN '' ELSE 'X' END AS Claims, CASE WHEN AU.RoleID IS NULL THEN '' ELSE 'X' END AS Auths, 
                      CASE WHEN Elig.RoleID IS NULL THEN '' ELSE 'X' END AS Elig, CASE WHEN EOB.RoleID IS NULL THEN '' ELSE 'X' END AS EOB, 
                      CASE WHEN CD.RoleID IS NULL THEN '' ELSE 'X' END AS Cap, CASE WHEN EL.RoleID IS NULL THEN '' ELSE 'X' END AS EligDownload,
                          (SELECT     COUNT(UserID) AS Expr1
                            FROM          UrlLog
                            WHERE      (UserID = U.UserID)) AS Views
FROM         Users AS U LEFT OUTER JOIN
                      UserRoles AS CD ON U.UserID = CD.UserID AND CD.RoleID = '116' LEFT OUTER JOIN
                      UserRoles AS EL ON U.UserID = EL.UserID AND EL.RoleID = '85' LEFT OUTER JOIN
                      UserRoles AS Elig ON U.UserID = Elig.UserID AND Elig.RoleID = '91' LEFT OUTER JOIN
                      UserRoles AS CL ON U.UserID = CL.UserID AND CL.RoleID = '90' LEFT OUTER JOIN
                      UserRoles AS AU ON U.UserID = AU.UserID AND AU.RoleID = '88' LEFT OUTER JOIN
                      UserRoles AS EOB ON U.UserID = EOB.UserID AND EOB.RoleID = '86' LEFT OUTER JOIN
                      UserPortals AS UP ON U.UserID = UP.UserId LEFT OUTER JOIN
                      _CHCN_COMPANY_VS AS CC ON U.UserID = CC.UserID LEFT OUTER JOIN
                      aspnet_Users AS ASP ON U.Username = ASP.UserName
--WHERE     (CC.CompanyID NOT IN ('CHCNCHC', '94-2232394', '94-2235908', '94-1744108', '94-2502308', '23-7135928', '23-7255435', '23-7118361', '94-1667294')) 
WHERE     (CC.CompanyID NOT IN ('CHCNCHC', '942232394', '942235908', '941744108', '942502308', '237135928', '237255435', '237118361', '941667294')) 
and UP.CreatedDate between @StartDate and @EndDate
ORDER BY CC.CompanyID, U.LastName









GO
