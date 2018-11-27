SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[CHCNPortal3_ValidateLocalAdmin]
	-- check if there is already a local admin under this Tax-ID, NPI and Department
	-- Note: Assuming all Tax-IDs have hyphens removed
	
	@TaxID VARCHAR(11),
	@DeptRoleName VARCHAR(50),
	@NPI varchar(10)
	
AS
IF @TaxID IS NULL OR @DeptRoleName IS NULL 
	RETURN
ELSE
	BEGIN
		
		IF @NPI IS NULL -- Validate based on Tax ID and Department only
			BEGIN 
				-- check if there exists a local admin with the given Tax ID and Department 
				SELECT count(*) 
				FROM	Portal_DNN7.DBO.Users u, 
						Portal_DNN7.DBO.UserProfile up, 
						Portal_DNN7.DBO.UserRoles LocalAdminUR,
						Portal_DNN7.DBO.UserRoles DeptUR	
				WHERE	u.UserID = up.UserID 
						AND up.PropertyDefinitionID = 
							(SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition]
								WHERE PropertyName='CompanyID1') -- TaxID
						AND REPLACE(up.PropertyValue,'-','')  = @TaxID
						and u.userid=DeptUR.userid
						and u.userid=LocalAdminUR.userid
						and DeptUR.roleid = (select roleid from Portal_DNN7.DBO.Roles DeptRole where DeptRole.RoleName = @DeptRoleName)
						and LocalAdminUR.roleid = (select roleid from Portal_DNN7.DBO.Roles LocalAdminRole where LocalAdminRole.RoleName = 'Local Admin')
			END
		ELSE
			BEGIN
				-- check if there exists a local admin with the given TaxID, Department and NPI
				SELECT count(*) 
				FROM	Portal_DNN7.DBO.Users u, 
						Portal_DNN7.DBO.UserProfile TaxID_UP, 
						Portal_DNN7.DBO.UserProfile NPI_UP, 
						Portal_DNN7.DBO.UserRoles LocalAdminUR,
						Portal_DNN7.DBO.UserRoles DeptUR	
				WHERE	u.UserID = TaxID_UP.UserID 
						AND TaxID_UP.PropertyDefinitionID = (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition]
								WHERE PropertyName='CompanyID1') -- TaxID
						AND REPLACE(TaxID_UP.PropertyValue,'-','')  = @TaxID
						
						AND u.UserID = NPI_UP.UserID 
						AND NPI_UP.PropertyDefinitionID = (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition]
								WHERE PropertyName='CompanyNPI1') -- npi 
						AND NPI_UP.PropertyValue = @NPI
						
						and u.userid=DeptUR.userid
						and u.userid=LocalAdminUR.userid
						and DeptUR.roleid = (select roleid from Portal_DNN7.DBO.Roles DeptRole where DeptRole.RoleName = @DeptRoleName)
						and LocalAdminUR.roleid = (select roleid from Portal_DNN7.DBO.Roles LocalAdminRole where LocalAdminRole.RoleName = 'Local Admin')
			END
	END
GO
