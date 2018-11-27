SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE procedure [dbo].[CHCNPortal_GetUsers_Providers]

as

-- UPDATED 12/10/2013 TO INCLUDE USER PHONE, FAX AND MSO AUTH REQUEST ROLE
-- Updated to remove hypen in the list of company IDs since we removed all hypens in UserProfile table SK.6/9/2016
-- Upated to use new roles and added ePDR role and removed CAP and EligDownload (CHCs only), CTA, 06/14/2017

SELECT  DISTINCT   CC.CompanyID, CC.Company, U.LastName, U.FirstName, U.Email,P.PROPERTYVALUE AS PHONE, F.PROPERTYVALUE AS FAX, CONVERT(char(10), UP.CreatedDate, 101) AS CreateDate, CONVERT(char(10), 
                      ASP.LastActivityDate, 101) AS LastLoginDate, CASE WHEN UP.Authorised = '1' THEN 'YES' ELSE 'NO' END AS Authorized, 
                      CASE WHEN CL.RoleID IS NULL THEN '' ELSE 'X' END AS Claims, CASE WHEN AU.RoleID IS NULL THEN '' ELSE 'X' END AS Auths, 
                      CASE WHEN AR.RoleID IS NULL THEN '' ELSE 'X' END AS AuthReq,
                      CASE WHEN Elig.RoleID IS NULL THEN '' ELSE 'X' END AS Elig, CASE WHEN EOB.RoleID IS NULL THEN '' ELSE 'X' END AS EOB, 
                      CASE WHEN PD.RoleID IS NULL THEN '' ELSE 'X' END AS ePDR, 
                          (SELECT     COUNT(UserID) AS Expr1
                            FROM          UrlLog
                            WHERE      (UserID = U.UserID)) AS Views
FROM         Users AS U LEFT OUTER JOIN
                      UserRoles AS PD ON U.UserID = PD.UserID AND PD.RoleID = '120' LEFT OUTER JOIN
                      --UserRoles AS EL ON U.UserID = EL.UserID AND EL.RoleID = '85' LEFT OUTER JOIN
                      UserRoles AS Elig ON U.UserID = Elig.UserID AND Elig.RoleID = '91' LEFT OUTER JOIN
                      UserRoles AS CL ON U.UserID = CL.UserID AND CL.RoleID = '90' LEFT OUTER JOIN
                      UserRoles AS AU ON U.UserID = AU.UserID AND AU.RoleID = '88' LEFT OUTER JOIN
                      UserRoles AS AR ON U.UserID = AR.UserID AND AR.RoleID = '89' LEFT OUTER JOIN
                      UserRoles AS EOB ON U.UserID = EOB.UserID AND EOB.RoleID = '86' LEFT OUTER JOIN
                      UserPortals AS UP ON U.UserID = UP.UserId LEFT OUTER JOIN
                      _CHCN_COMPANY_VS AS CC ON U.UserID = CC.UserID LEFT OUTER JOIN
                      aspnet_Users AS ASP ON U.Username = ASP.UserName LEFT JOIN
                      UserProfile AS P ON U.UserID=P.UserID AND P.PropertyDefinitionID='28' LEFT JOIN
                      UserProfile AS F ON U.UserID=F.UserID AND F.PropertyDefinitionID='30' 
WHERE  nullif(CC.CompanyID,' ') is not null and nullif(CC.Company,' ') is not null 
--and    (CC.CompanyID NOT IN ('CHCNCHC', '94-2232394', '94-2235908', '94-1744108', '94-2502308', '23-7135928', '23-7255435', '23-7118361', '94-1667294')) 
and    (CC.CompanyID NOT IN ('CHCNCHC', '942232394', '942235908', '941744108', '942502308', '237135928', '237255435', '237118361', '941667294')) 
and UP.CreatedDate between DATEADD(month, -1, GetDate()) and DateAdd(day, -1,GETDATE()) 
ORDER BY CC.CompanyID, U.LastName








GO
