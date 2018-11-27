SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Synergy BIS, Updated by LC from CHCN
-- Create date: 05/06/2016, last modified: 5/27/2016
-- Description:	Returns existing portal Users who have not been assigned to a local admin 
--						Exclude Local Admins
--						Exclude Users who belong to a department, and has a NPI
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPORTAL3_GetExistingNoLocalAdminUsers]
@COMPANYID varchar(20)

AS
DECLARE @LocalAdminRole varchar(20) = 'Local Admin'
DECLARE @MasterPortalID int = 9
DECLARE @TelephonePropertyName varchar(20) = N'Telephone'
DECLARE @FaxPropertyName varchar(20) = N'Fax'
DECLARE @LocalAdminRoleID int = (SELECT RoleID FROM Roles WHERE RoleName = @LocalAdminRole)

Select *
FROM 
(SELECT distinct 
      U.UserID,
      U.Username,
      U.LastName,
      U.FirstName,
      U.Email,
	  (	SELECT UPP.PropertyValue FROM UserProfile UPP, ProfilePropertyDefinition PPD 
		WHERE 	UPP.PropertyDefinitionID=PPD.PropertyDefinitionID and UPP.UserID=U.UserID 
				and PPD.PropertyName = @TelephonePropertyName AND PortalID = @MasterPortalID ) AS Phone,
	  ( SELECT UPX.PropertyValue FROM UserProfile UPX, ProfilePropertyDefinition PPD 
		WHERE 	UPX.PropertyDefinitionID=PPD.PropertyDefinitionID and UPX.UserID=U.UserID 
				and PPD.PropertyName = @FaxPropertyName AND PortalID = @MasterPortalID ) AS Fax,
	  ( SELECT UP_NPI.PropertyValue FROM UserProfile UP_NPI, ProfilePropertyDefinition PPD 
		WHERE 	UP_NPI.PropertyDefinitionID=PPD.PropertyDefinitionID and UP_NPI.UserID=U.UserID 
				and PPD.PropertyName = 'CompanyNPI1') AS NPI

FROM  Users as U
      LEFT OUTER JOIN UserRoles LocalAdminRole ON U.UserID = LocalAdminRole.UserID AND LocalAdminRole.RoleID = @LocalAdminRoleID
	  LEFT OUTER JOIN UserRoles DeptRole ON U.UserID = DeptRole.UserID AND DeptRole.RoleID in
			(SELECT RoleID FROM	[Portal_DNN7].[dbo].[Roles] Where RoleName in ('Dept_MemberServices', 'Dept_AuthorizationReferral', 'Dept_Billing'))
      LEFT OUTER JOIN UserPortals ON U.UserID = UserPortals.UserId
      LEFT OUTER JOIN _CHCN_COMPANY_VS ON U.UserID = _CHCN_COMPANY_VS.UserID
	  
WHERE (_CHCN_COMPANY_VS.CompanyID = @COMPANYID) -- Note: No need to strip out hyphens from COMPANYID comparison LC 5/27 since both data from UserProfile
AND LocalAdminRole.RoleID is null -- not a local admin
AND DeptRole.RoleID is null -- isn't assigned any department
AND ISNULL(UserPortals.Authorised,0) <> 0 -- authorized user
) as A
WHERE A.NPI is null or NPI = '' -- no NPI value
ORDER BY A.FirstName ASC
GO
