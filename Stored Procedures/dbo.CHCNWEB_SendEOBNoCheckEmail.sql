SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- Added code to strip out hyphens from COMPANYID comparison SK.5/17/2016
CREATE PROCEDURE [dbo].[CHCNWEB_SendEOBNoCheckEmail]

AS

BEGIN

-- Creates temp table of users with EOB download access and have NO CHECK

truncate table dbo._CHCNWEB_EOBNoCheckMax_Emails


-- Get last EOB with NO CHECK with Vendor ID

INSERT INTO dbo._CHCNWEB_EOBNoCheckMax_Emails
SELECT *
FROM dbo._CHCN_EOBUsers
WHERE REPLACE(CompanyID,'-','') In (SELECT REPLACE(VENDORID,'-','') FROM [EZWEB].[dbo].[CHCNWEB_EOB_NOCHECK_MAX])

DECLARE @UserID int
DECLARE @Message nvarchar(400)
DECLARE @RC int
DECLARE @Email nvarchar(256)

DECLARE EOBMail CURSOR READ_ONLY
FOR
SELECT UserID, Email FROM dbo._CHCNWEB_EOBNoCheckMax_Emails
OPEN EOBMail
FETCH NEXT FROM EOBMail INTO @UserID, @Email
WHILE (@@fetch_status <> -1)
BEGIN
        IF (@@fetch_status <> -2)
        BEGIN

                        SELECT @message = FirstName+' '+ LastName+', this is an automatically generated notification for a new EOB with NO CHECK that is now available for download from the Community Health Center Network Provider Network Web Portal. You can download this now by going to https://connect.chcnetwork.org.'
                        FROM dbo._CHCNWEB_EOBNoCheckMax_Emails
                        Where UserID = @UserID
						-- -- updated from Karen Matsuoka to Jessica Rojas, 12/10/2013 @from = N'jrojas@chcnetwork.org',
                        exec @RC = master.dbo.CHCNEDI_SendEmail @to=@Email, @subject = 'New EOB Download' , @body = @Message, @body_format='Text'

                END
             FETCH NEXT FROM EOBMail INTO @UserID
END

CLOSE EOBMail
DEALLOCATE EOBMail

END





GO
