SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- SK.06/06/2017
-- When the users account has been inactive for 6 months the account is automatically deactivated. 
-- The user should receive an email alert of the pending deactivation 72 hours prior to deactivation. (PRIOR-1073)
-- The email notice should also go to the users local admin. (Excluded from 4.1.0 release)
-- =============================================
CREATE PROCEDURE [dbo].[CHCNWEB_SendPendingInactiveUserEmail]
AS
    BEGIN

        SET NOCOUNT ON;

		DECLARE @CurYear CHAR(4) = DATEPART(YEAR, GETDATE()) 
		DECLARE @UserID INT 
		DECLARE @Email VARCHAR(256)
		DECLARE @MAXID INT = 0
		DECLARE @ID INT = 0
		DECLARE @MESSAGE VARCHAR(MAX)
		
		--DECLARE @LocalAdminRoleName VARCHAR(20) = N'Local Admin'
		--WITH LocalAdmin_CTE (LocalAdminUserID, UserName, LocalAdminName, CompanyID1, Email)		
		--	AS
		--	(
		--		SELECT DISTINCT u.UserID, u.Username, (u.FirstName + ' ' + u.LastName) AS LocalAdmin, up.PropertyValue AS CompanyID1, u.Email
		--		FROM Users as u
		--			INNER JOIN UserRoles LocalAdminRole ON u.UserID = LocalAdminRole.UserID AND LocalAdminRole.RoleID = 87 
		--			INNER JOIN dbo.UserProfile UP ON u.UserID = up.UserID AND PropertyDefinitionID = (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = N'CompanyID1' AND PortalID = 0)
		--	)	

		--		SELECT DISTINCT (U.FirstName + ' ' + U.LastName) AS LocalAdmin, U.UserID
		--		FROM Users as U
		--			LEFT OUTER JOIN UserRoles LocalAdminRole ON U.UserID = LocalAdminRole.UserID AND LocalAdminRole.RoleID = 87
		--			LEFT OUTER JOIN UserPortals ON U.UserID = UserPortals.UserId
		--			LEFT OUTER JOIN _CHCN_COMPANY_VS ON U.UserID = _CHCN_COMPANY_VS.UserID
		--		WHERE (_CHCN_COMPANY_VS.CompanyID = '941744108') AND LocalAdminRole.RoleID IS NOT NULL
				
		INSERT INTO _CHCNWEB_PendingInactiveUserEmailLog (UserID, UserName, UserEmail, UserCreateDate, UserLastLoginDate, UserAuthorized)			
		SELECT DISTINCT
                up.UserID ,
                au.UserName , --u.FirstName, u.LastName, 
				am.Email,
                am.CreateDate ,
                am.LastLoginDate ,
                up.Authorised                 
        FROM    dbo.vw_aspnet_Users au
                RIGHT OUTER JOIN dbo.Users u ON au.UserName = u.Username
                INNER JOIN dbo.UserPortals up ON u.UserID = up.UserId
                INNER JOIN dbo._CHCN_COMPANY_VS cv ON u.UserID = cv.UserID 
                LEFT OUTER JOIN dbo.vw_aspnet_MembershipUsers am ON au.UserName = am.UserName
				--LEFT OUTER JOIN dbo.UserProfile uf ON u.UserID = uf.UserID AND uf.PropertyDefinitionID = (SELECT PropertyDefinitionID FROM [dbo].[ProfilePropertyDefinition] WHERE PropertyName = N'CompanyID1' AND PortalID = 0)				
        WHERE   ( up.Authorised = 1 )
                AND ( am.CreateDate <> am.LastLoginDate )
                AND ( NOT ( cv.CompanyID IN ( N'DEMO', N'CHCNCHC' ) ) )
                AND ( DATEDIFF(MONTH,
                               DATEADD(DAY,3,am.LastLoginDate),
                               GETDATE()) >= 6 )
                AND ( up.UserId NOT IN (
                      SELECT    U.UserID
                      FROM      dbo.Users AS U
                                INNER JOIN dbo.UserRoles AS R ON U.UserID = R.UserID
                      WHERE     ( R.RoleID = 87 ) ) )

		IF OBJECT_ID('tempdb.dbo.#temp_PendingInactiveUsers','U') IS NOT NULL 
		DROP TABLE #temp_PendingInactiveUsers;
		CREATE TABLE #temp_PendingInactiveUsers (ID INT, Email VARCHAR(256))

		INSERT INTO #temp_PendingInactiveUsers (ID, Email)
		SELECT ID, u.Email FROM _CHCNWEB_PendingInactiveUserEmailLog p INNER JOIN Users u ON p.UserID = u.UserID WHERE EmailSentDate IS NULL ORDER BY ID

		SELECT @MAXID = MAX(ID) FROM #temp_PendingInactiveUsers

		--LOOP Each User to Send Email
		WHILE @MAXID > @ID 
			BEGIN
				SELECT @ID = ID, @Email = Email FROM #temp_PendingInactiveUsers WHERE ID > @ID ORDER BY ID

				--Get Local Admin
				--EXEC [dbo].[CHCNPORTAL3_GetLocalAdminForUser] 
				SELECT @MESSAGE = '<head> <link href="https://fonts.googleapis.com/css?family=Roboto:500,300,700" rel="stylesheet" type="text/css"></head><html> <body style="margin: 0; padding: 0; background: #efefef;"> <table cellpadding=0 cellspacing=0 style="width: 100%;"><tr><td style="padding: 12px 2%;"> <table cellpadding=0 cellspacing=0 style="margin: 0 auto; background: #fff; width: 900px;"><tr> <td style="padding: 2% 0;"><img src="https://connect.chcnetwork.org/Portals/9/Images/CHCN_LOGO_HORIZONTAL_RGB.png" width="400" style="width: 50%; max-width: 400px"></td> <td align="right"><img src="https://connect.chcnetwork.org/Portals/_Default/Skins/Connect/Images/chcn_connect_logo.png" width="300" style="width: 50%; max-width: 300px; float: right"></td> </tr></table> <table cellpadding=0 cellspacing=0 style="margin: 0 auto; background: #fff; width: 900px;"><tr> <td><img src="https://connect.chcnetwork.org/Portals/_Default/Skins/Connect/Images/Banner.png" width="900" style="width: 100%; display: block"></td> </tr></table> <table cellpadding=0 cellspacing=0 style="margin: 0 auto; background: #fff; width: 900px;"><tr><td style="padding: 4%;"> <div> <h1 style="font-family: ''Roboto'', sans-serif; font-weight: 300; font-size: 44px">Please Read: Your CHCN portal account will be deactivated if you do not take action.</h1> <p style="font-family: ''Roboto'', sans-serif; font-weight: 300"> Your CHCN Connect account has been inactive for almost 6 months. Inactive accounts are deactivated after 6 months. To keep your account from being deactivated you must log-in within the next 48 hours. If you wish to have your account closed no further action is required.<br> If your account is deactivated and you need to reactivate it contact your local admin. <br> Thank you,<br> CHCN Portal Support </p> <br> </div> </td></tr></table> <table cellpadding=0 cellspacing=0 style="margin: 0 auto; background: #203535; width: 900px;"><tr><td style="padding: 4%;"> <div> <p style="font-family: ''Roboto'', sans-serif; color:#fff; font-size: 14px; font-weight: 300"> Community Health Center Network <br> 101 Callan Avenue, Suite 300 <br> San Leandro, CA 94577 <br> M-F 9:00am to 5:00pm </p> <p style="padding: 2% 0; border-top: solid 1px #fff; font-family: ''Roboto'', sans-serif; color:#fff; font-size: 14px; font-weight: 300"> Copyright ' + @CurYear + ' by Community Health Center Network </p> </div> </td></tr></table> </td></tr></table> </body></html>'
				--PRINT @MESSAGE
				EXEC [master].[dbo].[CHCNEDI_SendEmail] @to=@Email, @subject= 'CHCN Connect Provider Portal Account Deactivation Notice', @body=@Message, @body_format='HTML'

				UPDATE _CHCNWEB_PendingInactiveUserEmailLog
				SET EmailSentDate = GETDATE()
				WHERE ID = @ID

			END

    END;
GO
