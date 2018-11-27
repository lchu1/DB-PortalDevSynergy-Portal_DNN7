SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- SK.8/12/2016
-- Archive log records to SiteLog_Archive
-- Delete log records from SiteLog older than 40 days
-- =============================================
CREATE PROCEDURE [dbo].[usp_ArchiveSiteLog]
	
AS
BEGIN
	
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN TRAN

		--1. Insert New Records in SiteLog where SiteLogId not in SiteLog_Archive table - Excluding Recent Records (Last 40 Days)
		INSERT INTO SiteLog_Archive (SiteLogId, DateTime, PortalId, UserId, Referrer, Url, UserAgent, UserHostAddress, UserHostName, TabId, AffiliateId)
		SELECT SiteLogId, DateTime, PortalId, UserId, Referrer, Url, UserAgent, UserHostAddress, UserHostName, TabId, AffiliateId
		FROM dbo.SiteLog
		WHERE ABS(DATEDIFF(DAY,DateTime,GETDATE())) >= 40 AND SiteLogId NOT IN (SELECT SiteLogId FROM SiteLog_Archive)

		--2. Remove the records in SiteLog where SiteLogId in SiteLog_Archive table 
		DELETE FROM dbo.SiteLog
		WHERE SiteLogId IN (SELECT SiteLogId FROM SiteLog_Archive)

		COMMIT TRAN

	END TRY
	BEGIN CATCH		

		IF (XACT_STATE()) = -1 --active transaction but uncommittable			
				ROLLBACK TRAN;		
		ELSE --0 - no active transaction, 1 - active and committable
			COMMIT TRAN;		

		DECLARE @MESSAGE VARCHAR(1000) = ''
		DECLARE @SUBJECT VARCHAR(100) = ''
	
		SET @SUBJECT='ERROR: CONNECT - SiteLog Archive Process Failure'		
		SET @MESSAGE = 'ERROR DESCRIPTION: ' + ERROR_MESSAGE()
		
		EXEC [MASTER].[DBO].[CHCNEDI_SendEmail] @to='skang@chcnetwork.org' ,@subject=@SUBJECT , @body=@MESSAGE, @body_format = 'TEXT'

	END CATCH

END
GO
