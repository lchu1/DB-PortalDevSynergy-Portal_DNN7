SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Synergy 09/28/2016
-- Get a user's profile
-- =============================================
CREATE PROCEDURE [dbo].[CHCNWEB3_GetUserProfile]

@UserId INT

AS

DECLARE @MasterPortalID INT = 9
DECLARE @PhonePropertyName VARCHAR(20) = N'Telephone'
DECLARE @FaxPropertyName VARCHAR(20) = N'Fax'

SELECT DISTINCT
	Users.UserID AS USERID,
	(Users.FirstName + ' ' + Users.LastName) AS FULLNAME,
	PH.PropertyValue AS PHONE,
	FX.PropertyValue AS FAX,
	Users.Email AS EMAIL
FROM [Portal_DNN7].[dbo].[Users]

LEFT OUTER JOIN [Portal_DNN7].[dbo].[UserProfile] PH ON Users.UserID = PH.UserID
AND PH.PropertyDefinitionID = (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @PhonePropertyName AND PortalID = @MasterPortalID)

LEFT OUTER JOIN [Portal_DNN7].[dbo].[UserProfile] FX ON Users.UserID = FX.UserID
AND FX.PropertyDefinitionID = (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @FaxPropertyName AND PortalID = @MasterPortalID)

WHERE Users.UserID = @UserID



GO
