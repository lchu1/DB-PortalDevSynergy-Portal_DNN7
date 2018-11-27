SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE      procedure [dbo].[CHCNWEB_PurgeUsers]

as

--truncate table CHCN_Purged_Users
--select * from #CHCNPURGEDUSERS

-- Archive purged users to CHCN_Purged_Users table
insert into CHCN_Purged_Users(UserID1,UserID2,UserName,FirstName,LastName,Email,Company,CompanyID,CreateDate,LastLoginDate,LastActivityDate,Authorised)
select UserID1,UserID2,UserName,FirstName,LastName,Email,Company,CompanyID,CreateDate,LastLoginDate,LastActivityDate,Authorised
from _CHCN_UsersNotLoggedIn
where DateDiff(day, createdate, GetDate())>=186
order by createdate desc

--create temp table for processing
select UserID1,UserID2,UserName,FirstName,LastName,Email,Company,CompanyID,CreateDate,LastLoginDate,LastActivityDate,Authorised
into #CHCNPURGEDUSERS
from _CHCN_UsersNotLoggedIn
where DateDiff(day, createdate, GetDate())>=183
order by createdate desc

-- delete from aspnet_Membership table
delete aspnet_Membership 
from aspnet_Membership a, #CHCNPURGEDUSERS p
where a.UserID=p.UserID1

-- delete from aspnet_Users table
delete aspnet_Users 
from aspnet_Users a, #CHCNPURGEDUSERS p
where a.UserID=p.UserID1 and a.username=p.username

-- delete from UserPortals table
delete UserPortals 
from UserPortals u, #CHCNPURGEDUSERS p
where u.UserID=p.UserID2

-- delete from UseProfile table
delete UserProfile 
from UserProfile u, #CHCNPURGEDUSERS p
where u.UserID=p.UserID2

-- delete from UseRoles table
delete UserRoles 
from UserRoles u, #CHCNPURGEDUSERS p
where u.UserID=p.UserID2

-- delete from Users table
delete Users 
from Users u, #CHCNPURGEDUSERS p
where u.UserID=p.UserID2

update CHCN_Purged_Users
set DatePurged=GetDate()
from CHCN_Purged_Users u, #CHCNPURGEDUSERS p
where u.userid2=p.userid2 and u.DatePurged is null

drop table #CHCNPURGEDUSERS


GO
