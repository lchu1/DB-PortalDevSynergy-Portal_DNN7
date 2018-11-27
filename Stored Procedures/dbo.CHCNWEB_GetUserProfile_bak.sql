SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










CREATE       procedure [dbo].[CHCNWEB_GetUserProfile_bak]

	@UserId int

AS
SELECT     DISTINCT FN.UserID AS USERID, FN.PropertyValue + ' ' + LN.PropertyValue AS FULLNAME, 
	   PHONE = CASE WHEN PH.PropertyDefinitionID = '28' THEN LEFT(REPLACE(REPLACE(PH.PropertyValue, '-', ''), ' ', ''),3)+'-'+ 
	   SUBSTRING(REPLACE(REPLACE(PH.PropertyValue, '-', ''), ' ', ''),4,3)+'-'+
	   RIGHT(REPLACE(REPLACE(PH.PropertyValue, '-', ''), ' ', ''),4) ELSE '' END, 
           FAX = CASE WHEN FX.PropertyDefinitionID = '30' THEN LEFT(REPLACE(REPLACE(FX.PropertyValue, '-', ''), ' ', ''),3)+'-'+
	   SUBSTRING(REPLACE(REPLACE(PH.PropertyValue, '-', ''), ' ', ''),4,3)+'-'+
           RIGHT(REPLACE(REPLACE(PH.PropertyValue, '-', ''), ' ', ''),4) ELSE '' END
FROM         UserProfile FN INNER JOIN
             UserProfile FX ON FN.UserID = FX.UserID INNER JOIN
             UserProfile PH ON FN.UserID = PH.UserID INNER JOIN
             UserProfile LN ON FN.UserID = LN.UserID
	WHERE   FN.UserId = @UserId and (FN.PropertyDefinitionID = '23') AND (LN.PropertyDefinitionID = '25')
		AND (PH.PropertyDefinitionID = '28')







GO
