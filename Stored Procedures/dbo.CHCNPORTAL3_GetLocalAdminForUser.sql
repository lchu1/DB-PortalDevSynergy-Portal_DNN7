SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Synergy
-- Description:	Retrieves the name of the Local Admin for the given UserID
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPORTAL3_GetLocalAdminForUser]

@COMPANYID varchar(20),
@NPI varchar(10),
@PortalID int

AS

DECLARE @LocalAdminRole varchar(20) = 'Local Admin'
DECLARE @NPIPropertyName varchar(20) = N'CompanyNPI1'
DECLARE @MasterPortalID int = 9
DECLARE @LocalAdminRoleID int = (SELECT RoleID FROM Roles WHERE RoleName = @LocalAdminRole AND PortalID = @PortalID)

IF @NPI is NULL or @NPI = ''
	BEGIN

	SELECT DISTINCT (U.FirstName + ' ' + U.LastName) AS LocalAdmin, U.UserID
	FROM Users as U
		LEFT OUTER JOIN UserRoles LocalAdminRole ON U.UserID = LocalAdminRole.UserID AND LocalAdminRole.RoleID = @LocalAdminRoleID
		LEFT OUTER JOIN UserPortals ON U.UserID = UserPortals.UserId
		LEFT OUTER JOIN _CHCN_COMPANY_VS ON U.UserID = _CHCN_COMPANY_VS.UserID
	WHERE (_CHCN_COMPANY_VS.CompanyID = @COMPANYID) AND LocalAdminRole.RoleID IS NOT NULL

	END
ELSE
	BEGIN

	SELECT DISTINCT (U.FirstName + ' ' + U.LastName) AS LocalAdmin, U.UserID
	FROM Users as U
		LEFT OUTER JOIN UserRoles LocalAdminRole ON U.UserID = LocalAdminRole.UserID AND LocalAdminRole.RoleID = @LocalAdminRoleID
		LEFT OUTER JOIN [Portal_DNN7].[dbo].[UserProfile] NPI ON U.UserID = NPI.UserID 
			AND NPI.PropertyDefinitionID = (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @NPIPropertyName AND PortalID = @MasterPortalID) 
		LEFT OUTER JOIN UserPortals ON U.UserID = UserPortals.UserId
		LEFT OUTER JOIN _CHCN_COMPANY_VS ON U.UserID = _CHCN_COMPANY_VS.UserID
	WHERE (_CHCN_COMPANY_VS.CompanyID = @COMPANYID) AND (NPI.PropertyValue = @NPI) AND LocalAdminRole.RoleID IS NOT NULL

	END	
GO
