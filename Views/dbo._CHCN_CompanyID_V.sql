SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




--Updated for sequence number to get all digits instead of only the last string SK.11/2/2016

CREATE VIEW [dbo].[_CHCN_CompanyID_V]
AS
SELECT     dbo.UserProfile.UserID, dbo.ProfilePropertyDefinition.PropertyCategory, dbo.ProfilePropertyDefinition.PropertyName AS CompanyID, 
                      dbo.UserProfile.PropertyValue, 
					  --RIGHT(dbo.ProfilePropertyDefinition.PropertyName, 1) AS Seq
					  SUBSTRING(dbo.ProfilePropertyDefinition.PropertyName,	PATINDEX('%[0-9]%', dbo.ProfilePropertyDefinition.PropertyName), 
						PATINDEX('%[0-9][^0-9]%', dbo.ProfilePropertyDefinition.PropertyName + 't') - PATINDEX('%[0-9]%', dbo.ProfilePropertyDefinition.PropertyName) + 1) AS Seq				
FROM         dbo.ProfilePropertyDefinition INNER JOIN
                      dbo.UserProfile ON dbo.ProfilePropertyDefinition.PropertyDefinitionID = dbo.UserProfile.PropertyDefinitionID
WHERE     (dbo.ProfilePropertyDefinition.PropertyCategory = N'CompanyID')






GO
