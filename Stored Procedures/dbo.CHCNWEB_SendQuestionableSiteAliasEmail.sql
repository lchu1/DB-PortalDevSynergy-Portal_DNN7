SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE  PROCEDURE [dbo].[CHCNWEB_SendQuestionableSiteAliasEmail]

AS

BEGIN
DECLARE @Message nvarchar(800)
DECLARE @RC int

IF ((SELECT COUNT(*) FROM dbo.PortalAlias Where HTTPAlias not in 
('connect.chcnetwork.org', 'connect2.chcnetwork.org', 'localhost', '10.1.1.20', '10.1.1.21', 'portal.chcnetwork.org', '64.201.243.170')) > 0)
  BEGIN

     SELECT @message = Char(10)+Char(10)+ 'This is an automatically generated notification.'+Char(10)+Char(10)+
			'A questionable site alias has been added: ' + HTTPAlias + ' on ' + 
			Convert(varchar(25), CreatedOnDate, 121) + '.'
     FROM dbo.PortalAlias
     Where HTTPAlias not in ('connect.chcnetwork.org', 'connect2.chcnetwork.org', 'localhost', '10.1.1.20', '10.1.1.21', 'portal.chcnetwork.org', '64.201.243.170')
     exec @RC = master.dbo.CHCNEDI_SendEmail @to = 'canicete@chcnetwork.org; lchu@chcnetwork.org', 
     @subject = 'ALERT - Questionable Site Alias Added' , @body = @Message, @body_format='Text'
   END

End









GO
