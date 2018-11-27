SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportImport_AddUpdateUsersProfilesBulk]
	@DataTable dbo.ExportImportUserProfileType READONLY,
	@Overwrite bit = 1
AS
BEGIN

	BEGIN TRANSACTION [UserProfilesInsert]
		----Update/Insert User Profile
		IF @Overwrite = 1
		BEGIN
			SELECT   
					UserProfile.ProfileID
				,dt.PropertyValue
				,dt.PropertyText 				
				,dt.Visibility 					
				,dt.ExtendedVisibility 				
			INTO #UserProfileUpdatesDataTable 
			FROM @DataTable dt INNER JOIN dbo.Users Users ON Users.UserID=dt.UserId
			INNER JOIN dbo.UserPortals UP ON UP.UserId=Users.UserID AND UP.PortalId=dt.PortalId 
			INNER JOIN dbo.UserProfile UserProfile ON UserProfile.UserID=Users.UserID AND UserProfile.PropertyDefinitionID = dt.PropertyDefinitionId
			WHERE UP.UserPortalId IS NOT NULL AND UP.PortalId=dt.PortalId AND UserProfile.ProfileID IS NOT NULL AND dt.IsSuperUser=0 AND Users.IsSuperUser=0

			UPDATE UserProfile
			SET
				UserProfile.PropertyValue 			= dt.PropertyValue,
				UserProfile.PropertyText 			= dt.PropertyText,
				UserProfile.Visibility 				= dt.Visibility,
				UserProfile.ExtendedVisibility 		= dt.ExtendedVisibility,
				UserProfile.LastUpdatedDate			= GETDATE()
			FROM dbo.UserProfile AS UserProfile
			INNER JOIN #UserProfileUpdatesDataTable AS dt ON UserProfile.ProfileID=dt.ProfileID
		
			DROP TABLE #UserProfileUpdatesDataTable;

			--Insert new User Profile
			SELECT   
					Users.UserID
				,dt.PropertyDefinitionId
				,dt.PropertyValue
				,dt.PropertyText 				
				,dt.Visibility 					
				,dt.ExtendedVisibility 				
			INTO #UserProfileInsertsDataTable 
			FROM @DataTable dt INNER JOIN dbo.Users Users ON Users.UserID=dt.UserId
			INNER JOIN dbo.UserPortals UP ON UP.UserId=Users.UserID AND UP.PortalId=dt.PortalId 
			LEFT JOIN dbo.UserProfile UserProfile ON UserProfile.UserID=Users.UserID AND UserProfile.PropertyDefinitionID = dt.PropertyDefinitionId
			WHERE UP.UserPortalId IS NOT NULL AND UP.PortalId=dt.PortalId AND UserProfile.ProfileID IS NULL AND dt.IsSuperUser=0  AND ISNULL(Users.IsSuperUser, 0)=0

			INSERT INTO dbo.UserProfile(
				[UserID]
				,[PropertyDefinitionID]
				,[PropertyValue]
				,[PropertyText]
				,[Visibility]
				,[LastUpdatedDate]
				,[ExtendedVisibility]
				)
			SELECT
				dt.UserId,
				dt.PropertyDefinitionId,
				dt.PropertyValue,
				dt.PropertyText,
				dt.Visibility,
				GETDATE(),
				dt.ExtendedVisibility
			FROM
				#UserProfileInsertsDataTable dt

			DROP TABLE #UserProfileInsertsDataTable;
		END
	COMMIT TRANSACTION [UserProfilesInsert]

END
GO
