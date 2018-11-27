SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO


CREATE    procedure [dbo].[CHCNWEB_GetUserProfile]

	@UserId int

AS
SELECT     DISTINCT FN.UserID AS USERID, FN.PropertyValue + ' ' + LN.PropertyValue AS FULLNAME, 
	   LEFT(REPLACE(REPLACE(dbo.CHCNWEBGetUserPhone(@UserID), '-', ''), ' ', ''),3)+'-'+ 
	   SUBSTRING(REPLACE(REPLACE(dbo.CHCNWEBGetUserPhone(@UserID), '-', ''), ' ', ''),4,3)+'-'+
	   RIGHT(REPLACE(REPLACE(dbo.CHCNWEBGetUserPhone(@UserID), '-', ''), ' ', ''),4) AS PHONE, 
           CASE WHEN dbo.CHCNWEBGetUserFax(@UserID) = '' THEN NULL ELSE  LEFT(REPLACE(REPLACE(dbo.CHCNWEBGetUserFax(@UserID), '-', ''), ' ', ''),3)+'-'+
	   SUBSTRING(REPLACE(REPLACE(dbo.CHCNWEBGetUserFax(@UserID), '-', ''), ' ', ''),4,3)+'-'+
           RIGHT(REPLACE(REPLACE(dbo.CHCNWEBGetUserFax(@UserID), '-', ''), ' ', ''),4) END As FAX, U.EMAIL
FROM         UserProfile FN INNER JOIN
             UserProfile LN ON FN.UserID = LN.UserID LEFT OUTER JOIN USERS U ON FN.USERID=U.USERID
WHERE   FN.UserId = @UserID and (FN.PropertyDefinitionID = '23') AND (LN.PropertyDefinitionID = '25') --(LN.PropertyDefinitionID = '37') UPDATED 03/14/2014, CTA


GO
