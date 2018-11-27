SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [dbo].[CHCNWEB_sendEventLogAlertEmail]
as

DECLARE @title nvarchar(800)
DECLARE @bodyText nvarchar(4000)

SELECT @title = 'Provider Portal EventLog Stats since ' + convert(varchar(25), dateadd(day,datediff(day,1,GETDATE()),0), 121)
SELECT @bodyText = '<div style="font-family:arial;font-size:12pt; color:red">'
SELECT @bodyText = @bodyText + '<table border=1><tr><td>Events</td><td>Num of Logs</td></tr>'+Replace((SELECT logtypekey, count(*) as num
  FROM [Portal_DNN7].[dbo].[EventLog] 
  where logCreateDate > dateadd(day,datediff(day,10,GETDATE()),0)
  group by logTypeKey
  for XML PATH ('')), '</num>', '</tr>')
  
SELECT @bodyText = Replace(Replace(@bodyText, '<logtypekey>', '<tr><td>'), '</logtypekey><num>', '</td><td>') + '</table>'

/****** General Exception Log ******/
SELECT @bodyText = @bodyText + 'General Exceptions:<br /><table border=1><tr><td>LogCreateDate</td><td>LogUserName</td>'
SELECT @bodyText = @bodyText + '<td>Error Message</td></tr>'
SELECT @bodyText = @bodyText + (SELECT LogCreateDate, CASE WHEN LogUserName is null THEN 'NONE' ELSE LogUsername END as LogUserName, Message
FROM [Portal_DNN7].[dbo].[EventLog] EL, [Portal_DNN7].[dbo].[exceptions] EX
WHERE logtypekey='GENERAL_EXCEPTION' and EL.ExceptionHash=EX.ExceptionHash 
		and logCreateDate > dateadd(day,datediff(day,10,GETDATE()),0) FOR XML PATH (''))
SELECT @bodyText = Replace(Replace(@bodyText, '<LogCreateDate>', '<tr><td>'), '</LogCreateDate><LogUserName>', '</td><td>')
SELECT @bodyText = Replace(Replace(@bodyText, '</LogUserName><Message>', '</td><td>'), '</Message>', '</td><tr>')
SELECT @bodyText = @bodyText + '</table>'

/****** Module Load Exception Log ******/
SELECT @bodyText = @bodyText + 'Module Load Exceptions:<br /><table border=1><tr><td>LogCreateDate</td><td>LogUserName</td>'
SELECT @bodyText = @bodyText + '<td>Error Message</td><td>Stack Trace</td></tr>'
SELECT @bodyText = @bodyText + (SELECT LogCreateDate, CASE WHEN LogUserName is null THEN 'NONE' ELSE LogUsername END as LogUserName, 
								Message, InnerStackTrace
FROM [Portal_DNN7].[dbo].[EventLog] EL, [Portal_DNN7].[dbo].[exceptions] EX
WHERE logtypekey='MODULE_LOAD_EXCEPTION' and EL.ExceptionHash=EX.ExceptionHash 
		and logCreateDate > dateadd(day,datediff(day,10,GETDATE()),0) FOR XML PATH (''))
SELECT @bodyText = Replace(Replace(@bodyText, '<LogCreateDate>', '<tr><td>'), '</LogCreateDate><LogUserName>', '</td><td>')
SELECT @bodyText = Replace(Replace(@bodyText, '</LogUserName><Message>', '</td><td>'), '</Message><InnerStackTrace>', '</td><td>')
SELECT @bodyText = Replace(@bodyText, '</InnerStackTrace>', '</td></tr>')
SELECT @bodyText = @bodyText + '</table>'

SELECT @bodyText = @bodyText + '</div>'    
exec [master].[dbo].[CHCNEDI_SendEmail] 
@to='lchu@chcnetwork.org', 
@subject= @title, 
@body=@bodyText, 
@body_format='Html'
GO
