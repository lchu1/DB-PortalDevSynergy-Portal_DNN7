SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImport_AddUpdateUserRolesBulk]
	@DataTable dbo.ExportImportUserRoleType READONLY,
	@Overwrite bit = 1
AS
BEGIN

	BEGIN TRANSACTION [UserRolesInsert]
		IF @Overwrite = 1
		BEGIN
			--Update UserRoles
			SELECT   
					UserRole.UserRoleId
				,dt.Status
				,dt.IsOwner 				
				,dt.EffectiveDate 					
				,dt.ExpiryDate 				
				,dt.IsTrialUsed 					
				,dt.LastModifiedByUserId 			
			INTO #UserRoleUpdatesDataTable 
			FROM @DataTable dt INNER JOIN dbo.Users Users ON Users.UserID=dt.UserId
			INNER JOIN dbo.UserPortals UP ON UP.UserId=Users.UserID AND UP.PortalId=dt.PortalId 
			INNER JOIN dbo.UserRoles UserRole ON UserRole.UserID=Users.UserID AND UserRole.RoleID=dt.RoleId
			WHERE UP.UserPortalId IS NOT NULL AND UP.PortalId=dt.PortalId AND UserRole.UserRoleId IS NOT NULL AND dt.IsSuperUser=0 AND Users.IsSuperUser=0

			UPDATE UserRoles
			SET
				UserRoles.Status 					= dt.Status,
				UserRoles.IsOwner 					= dt.IsOwner,
				UserRoles.EffectiveDate 			= dt.EffectiveDate,
				UserRoles.ExpiryDate 				= dt.ExpiryDate,
				UserRoles.IsTrialUsed 				= dt.IsTrialUsed,
				UserRoles.LastModifiedByUserID 		= dt.LastModifiedByUserId,
				UserRoles.LastModifiedOnDate		= GETDATE()
			FROM dbo.UserRoles AS UserRoles
			INNER JOIN #UserRoleUpdatesDataTable AS dt ON UserRoles.UserRoleId=dt.UserRoleId
		
			DROP TABLE #UserRoleUpdatesDataTable;

			--Insert new UserRoles
			SELECT   
					dt.UserId
				,dt.RoleId
				,dt.Status
				,dt.IsOwner 				
				,dt.EffectiveDate 					
				,dt.ExpiryDate 				
				,dt.IsTrialUsed 					
				,dt.CreatedByUserId 				
				,dt.LastModifiedByUserId 			
			INTO #UserRoleInsertsDataTable 
			FROM @DataTable dt INNER JOIN dbo.Users Users ON Users.UserID=dt.UserId
			INNER JOIN dbo.UserPortals UP ON UP.UserId=Users.UserID
			LEFT JOIN dbo.UserRoles UserRole ON UserRole.UserID=Users.UserID AND UserRole.RoleID=dt.RoleId
			WHERE UP.UserPortalId IS NOT NULL AND UP.PortalId=dt.PortalId AND UserRole.UserRoleId IS NULL AND dt.IsSuperUser=0  AND ISNULL(Users.IsSuperUser, 0)=0

			INSERT INTO dbo.UserRoles(
				UserId,
				RoleId,
				Status,
				IsOwner,
				EffectiveDate,
				ExpiryDate,
				IsTrialUsed,
				CreatedByUserID,
				CreatedOnDate,
				LastModifiedByUserID,
				LastModifiedOnDate
				)
			SELECT
				dt.UserID,
				dt.RoleId,
				dt.Status,
				dt.IsOwner,
				dt.EffectiveDate,
				dt.ExpiryDate,
				dt.IsTrialUsed,
				dt.CreatedByUserId,
				getdate(),
				dt.LastModifiedByUserId,
				getdate()
			FROM
				#UserRoleInsertsDataTable dt

			DROP TABLE #UserRoleInsertsDataTable;
		END
	COMMIT TRANSACTION [UserRolesInsert]

END
GO
