SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








CREATE   PROCEDURE [dbo].[CHCNWEB_SendInactiveUserEmail]

AS

BEGIN


-- Send email to users who have been inactive for 6 months
-- Unauthorize the account
-- Provide lik to Request form to re-enable accouunt
-- Updated to send emails to user who have been inactive for one year, CTA, 10/17/2014 
-- Updated to log the deactivated users into [EZWEB].[dbo].[CHCNPORTAL_LOG_USER_AUDIT] SK.06/05/2017

--Create temp table for processing
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[#chcnwebinactive]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[#chcnwebinactive]


select  distinct UserID1, UserID2, UserName, FirstName, LastName, Email, CreateDate, LastLoginDate
into #chcnwebinactive
from dbo._CHCN_InactiveUsers

--select * into _CHCNinactive_bak from #chcnwebinactive order by lastlogindate desc
-- select * from #chcnwebinactive

-- Update aspnet_Membership table
update aspnet_Membership
set IsApproved = 0
from aspnet_Membership a, #chcnwebinactive i
where a.UserId = i.UserID1

-- Update aspnet_Users table
update aspnet_Users
set LastActivityDate = GetDate()
from aspnet_Users a, #chcnwebinactive i
where a.UserId = i.UserID1

-- Update UserPortals table
update UserPortals
set Authorised = 0
from UserPortals u, #chcnwebinactive i
where u.UserId = i.UserID2

--Log the deactivated users 
INSERT INTO [EZWEB].[dbo].[CHCNPORTAL_LOG_USER_AUDIT] ([DATE],[USERID],[STATUS],[CHANGED_BY_ID],[TYPE],[USERNAME],[CHANGED_BY_USERNAME])
SELECT GETDATE(), UserID2, 'Deauthorized', 1, 'CHCN', u.Username, 'SYSTEM' FROM #chcnwebinactive iu INNER JOIN users u ON iu.UserID2 = u.UserID


--Send email to inactive users

DECLARE @UserID2 int
DECLARE @Message nvarchar(800)
DECLARE @RC int
DECLARE @Email nvarchar(256)

DECLARE InactiveUserEmail CURSOR READ_ONLY
FOR
SELECT UserID2, Email FROM dbo.#chcnwebinactive
OPEN InactiveUserEmail
FETCH NEXT FROM InactiveUserEmail INTO @UserID2, @Email
WHILE (@@fetch_status <> -1)
BEGIN
        IF (@@fetch_status <> -2)
        BEGIN

                        SELECT @message = FirstName+' '+ LastName+','+Char(10)+Char(10)+ 'This is an automatically generated notification from the Community Health Center Network Provider Portal Connect.'+Char(10)+Char(10)+
			'Your account with username ' + Username + ' has been inactive for at least 6 months. Your account has been disabled.'+Char(10)+
			'If you still require access, you must resubmit a request to your groups Local Administrator. Each group designated a '+Char(10)+
			'Local Administrator when they signed up for Connect. The role of the Local Administrator is to manage user accounts, '+Char(10)+
			'add, remove users and update access right on the site. If you do not know who your Local Administrator is contact our Portal '+Char(10)+
			'Support Team at 510-297-0480 or portalsupport@chcnetwork.org. '+Char(10)+Char(10)+
			'Thank you,'+Char(10)+
			'CHCN Portal Support Team'
			
			FROM dbo.#chcnwebinactive
                        Where UserID2 = @UserID2

exec [master].[dbo].[CHCNEDI_SendEmail] @to=@Email, @subject= 'Inactive CHCN Provider Access Account', @body=@Message, @body_format='Text'


                END
             FETCH NEXT FROM InactiveUserEmail INTO @UserID2, @Email
END

CLOSE InactiveUserEmail
DEALLOCATE InactiveUserEmail


--drop table #chcnwebinactive

END

GO
