SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO













CREATE   procedure [dbo].[CHCNWEB_GetUsersByCompany]
@COMPANYID varchar(20) 
as




SELECT Users.UserID, Users.Username, Users.LastName, Users.FirstName, Users.Email, CONVERT(char(10),UserPortals.CreatedDate,101) AS CreateDate,  
	   CONVERT(char(10),aspnet_Users.LastActivityDate,101) AS LastLoginDate, 
           Authorized = CASE WHEN UserPortals.Authorised = '1' THEN 'YES' ELSE 'NO' END,
           Claims = CASE WHEN Claims.RoleID is null THEN '' ELSE 'X' END, 
           Auths = CASE WHEN Auths.RoleID is null THEN '' ELSE 'X' END,
	   Elig = CASE WHEN Elig.RoleID is null THEN '' ELSE 'X' END,
	   EOB = CASE WHEN EOB.RoleID is null THEN '' ELSE 'X' END,
	   Cap = CASE WHEN CapDown.RoleID is null THEN '' ELSE 'X' END,
	   EligDownload = CASE WHEN Edown.RoleID is null THEN '' ELSE 'X' END,
	   AuthReq = CASE WHEN AuthReq.RoleID is null THEN '' ELSE 'X' END,
	   Document = CASE WHEN Document.RoleID is null THEN '' ELSE 'X' END,
	   MemberRetention = CASE WHEN Document.RoleID is null THEN '' ELSE 'X' END,
       Views = (select count(userid) from UrlLog where userid=users.userid)
FROM         Users LEFT OUTER JOIN
                      UserRoles CapDown ON Users.UserID = CapDown.UserID AND CapDown.RoleID = '89' LEFT OUTER JOIN --67
                      UserRoles EDown ON Users.UserID = EDown.UserID AND EDown.RoleID = '90' LEFT OUTER JOIN --57
                      UserRoles Elig ON Users.UserID = Elig.UserID AND Elig.RoleID = '87' LEFT OUTER JOIN --39
                      UserRoles Claims ON Users.UserID = Claims.UserID AND Claims.RoleID = '86' LEFT OUTER JOIN --38
                      UserRoles Auths ON Users.UserID = Auths.UserID AND Auths.RoleID = '85' LEFT OUTER JOIN --37
                      UserRoles EOB ON Users.UserID = EOB.UserID AND EOB.RoleID = '88' LEFT OUTER JOIN --23
                      UserRoles AuthReq ON Users.UserID = AuthReq.UserID AND AuthReq.RoleID = '91' LEFT OUTER JOIN --66
					  UserRoles Document ON Users.UserID = Document.UserID AND Document.RoleID = '92' LEFT OUTER JOIN --12
					  UserRoles MemberRetention ON Users.UserID = MemberRetention.UserID AND MemberRetention.RoleID = '95' LEFT OUTER JOIN --39
                      UserPortals ON Users.UserID = UserPortals.UserId LEFT OUTER JOIN
                      _CHCN_COMPANY_VS ON Users.UserID = _CHCN_COMPANY_VS.UserID LEFT OUTER JOIN
                      aspnet_Users ON Users.Username = aspnet_Users.UserName
WHERE     (_CHCN_COMPANY_VS.CompanyID = @COMPANYID)
ORDER BY UserPortals.CreatedDate DESC, Users.LastName








GO
