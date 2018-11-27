SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/****** Script for SelectTopNRows command from SSMS  ******/
CREATE PROC [dbo].[CHCN_GET_FAILED_LOGINS]

AS

SELECT [LogUserName],[UserName_Status]='INVALID',CONVERT(varchar,[LogCreateDate],101) as LogCreateDate,IP_Address,  IP_Status = CASE WHEN IP_ADDRESS NOT IN (select ip_address from _CHCN_IPAddresses_LoggedIn) THEN 'NOT VERIFIED' ELSE 'VERIFIED' END 
FROM _CHCN_FailedLogins_VS
where LogCreateDate between DATEADD(day,-7,GetDate()) and getdate() and LogUserName  not in(select username FROM [Portal].[dbo].[Users])
UNION ALL 
SELECT [LogUserName],[UserName_Status]='DISABLED',CONVERT(varchar,[LogCreateDate],101) as LogCreateDate,IP_Address,  IP_Status = CASE WHEN IP_ADDRESS NOT IN (select ip_address from _CHCN_IPAddresses_LoggedIn) THEN 'NOT VERIFIED' ELSE 'VERIFIED' END 
FROM _CHCN_FailedLogins_VS F join [Portal].[dbo].[_CHCN_Users_VS] U on F.LogUserName = U.Username  
where LogCreateDate between DATEADD(day,-7,GetDate()) and getdate() and U.Authorized = 'NO'
order by IP_address, LogCreateDate asc

  


GO
