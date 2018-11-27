SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_GetAllUsers]
	@PortalId		 int,
	@PageIndex       int,
	@PageSize        int,
	@IncludeDeleted  bit,
	@ToDateUtc		 datetime,
	@FromDateUtc	 datetime=NULL,
	@OnlyCount		 bit = 0
AS
BEGIN	
	DECLARE @ToDate datetime = DATEADD(hh,DATEDIFF(hh,GETUTCDATE(),GETDATE()),@ToDateUtc)
	DECLARE @FromDate datetime = DATEADD(hh,DATEDIFF(hh,GETUTCDATE(),GETDATE()),@FromDateUtc)

	--GET ONLY USERS COUNT
	IF @OnlyCount = 1
	BEGIN
		; WITH [tmpUsers] AS (
		SELECT U.UserID
			FROM dbo.[Users] U INNER JOIN dbo.[UserPortals] UP ON U.UserID=UP.UserId
			WHERE UP.PortalId = @PortalID AND U.IsSuperUser=0
			AND UP.IsDeleted <= CASE @IncludeDeleted WHEN 0 THEN 0 ELSE 1 END
			AND (CASE
			WHEN @FromDate IS NULL THEN 0
			WHEN U.LastModifiedOnDate IS NOT NULL THEN U.LastModifiedOnDate
			WHEN U.CreatedOnDate IS NOT NULL THEN U.CreatedOnDate
			ELSE ISNULL(@FromDate,0) END)>= ISNULL(@FromDate,0)
			AND (CASE
			WHEN U.LastModifiedOnDate IS NOT NULL THEN U.LastModifiedOnDate
			WHEN U.CreatedOnDate IS NOT NULL THEN U.CreatedOnDate
			ELSE @ToDate END)<= @ToDate
		)
		SELECT COUNT(UserID) TotalUsers FROM [tmpUsers];
	END
	--GET USERS
	IF @OnlyCount = 0
	BEGIN
		--Do not allow more than 1000 page size.
		IF @PageSize>1000
		BEGIN
			SET @PageSize = 1000;
		END
		IF ISNULL(@PageSize, 0) = 0
		BEGIN
			SET @PageSize = 500;
		END

		DECLARE
			@PageLowerBound int,
			@PageUpperBound int,
			@RowsToReturn int

		--Calculate paging information.
		EXEC dbo.[CalculatePagingInformation] @PageIndex, @PageSize, @RowsToReturn output, @PageLowerBound output, @PageUpperBound output
	
		--Prepare users query.
		; WITH [tmpUsers] AS (
			SELECT U.*, UP.IsDeleted IsDeletedPortal,dbo.[Export_UserName](U.CreatedByUserId) CreatedByUserName,dbo.[Export_UserName](U.LastModifiedByUserId) LastModifiedByUserName,  row_number() over (order by U.UserID) AS RowId
				FROM dbo.[Users] U INNER JOIN dbo.[UserPortals] UP ON U.UserID=UP.UserId
				WHERE UP.PortalId = @PortalID AND U.IsSuperUser=0
				AND UP.IsDeleted <= CASE @IncludeDeleted WHEN 0 THEN 0 ELSE 1 END
				AND (CASE
				WHEN @FromDate IS NULL THEN 0
				WHEN U.LastModifiedOnDate IS NOT NULL THEN U.LastModifiedOnDate
				WHEN U.CreatedOnDate IS NOT NULL THEN U.CreatedOnDate
				ELSE ISNULL(@FromDate,0) END)>= ISNULL(@FromDate,0)
				AND (CASE
				WHEN U.LastModifiedOnDate IS NOT NULL THEN U.LastModifiedOnDate
				WHEN U.CreatedOnDate IS NOT NULL THEN U.CreatedOnDate
				ELSE @ToDate END)<= @ToDate
		)

		--Perform paging on Users and Add them to temporary variable
		SELECT  * INTO #tmpPagedUsers FROM [tmpUsers]
			WHERE RowId > @PageLowerBound AND RowId < @PageUpperBound
			ORDER by RowId;

		--Users
		SELECT * FROM #tmpPagedUsers

		--UserAuthentication
		SELECT * FROM dbo.[UserAuthentication]
		WHERE UserId IN(SELECT UserID FROM #tmpPagedUsers)
			AND (CASE
			WHEN @FromDate IS NULL THEN 0
			WHEN LastModifiedOnDate IS NOT NULL THEN LastModifiedOnDate
			WHEN CreatedOnDate IS NOT NULL THEN CreatedOnDate
			ELSE ISNULL(@FromDate,0) END)>= ISNULL(@FromDate,0)
			AND (CASE
			WHEN LastModifiedOnDate IS NOT NULL THEN LastModifiedOnDate
			WHEN CreatedOnDate IS NOT NULL THEN CreatedOnDate
			ELSE @ToDate END)<= @ToDate

		--User Roles
		SELECT
			 [UserRoleID]
			,R.[RoleID]
			,[UserID]
			,[PortalID]
			,R.[RoleName]
			,[ExpiryDate]
			,[IsTrialUsed]
			,[EffectiveDate]
			,UR.[CreatedByUserID]
			,UR.[CreatedOnDate]
			,UR.[LastModifiedByUserID]
			,UR.[LastModifiedOnDate]
			,UR.[Status]
			,[IsOwner]
			,dbo.[Export_UserName](UR.CreatedByUserId) CreatedByUserName
			,dbo.[Export_UserName](UR.LastModifiedByUserId) LastModifiedByUserName
		FROM dbo.[UserRoles] UR INNER JOIN dbo.Roles R ON R.RoleID=UR.RoleID
		WHERE	UserID  IN(SELECT UserID FROM #tmpPagedUsers) AND R.PortalID = @PortalId
			AND (CASE
			WHEN @FromDate IS NULL THEN 0
			WHEN UR.LastModifiedOnDate IS NOT NULL THEN UR.LastModifiedOnDate
			WHEN UR.CreatedOnDate IS NOT NULL THEN UR.CreatedOnDate
			ELSE ISNULL(@FromDate,0) END)>= ISNULL(@FromDate,0)
			AND (CASE
			WHEN UR.LastModifiedOnDate IS NOT NULL THEN UR.LastModifiedOnDate
			WHEN UR.CreatedOnDate IS NOT NULL THEN UR.CreatedOnDate
			ELSE @ToDate END)<= @ToDate

		--User Profile
		SELECT
			UP.ProfileID,
			UP.UserID,
			UP.PropertyDefinitionID,
			UP.PropertyValue,
			UP.PropertyText,
			UP.Visibility,
			UP.ExtendedVisibility,
			UP.LastUpdatedDate,
			PPD.PropertyName
 		FROM dbo.[UserProfile] UP
		INNER JOIN dbo.[ProfilePropertyDefinition] PPD
		ON UP.PropertyDefinitionID=PPD.PropertyDefinitionID
		WHERE UserId IN(SELECT UserID FROM #tmpPagedUsers) AND PPD.PortalId=@PortalId
			AND (CASE
			WHEN @FromDate IS NULL THEN 0
			WHEN UP.LastUpdatedDate IS NOT NULL THEN UP.LastUpdatedDate
			ELSE ISNULL(@FromDate,0) END)>= ISNULL(@FromDate,0)
			AND (CASE
			WHEN UP.LastUpdatedDate IS NOT NULL THEN UP.LastUpdatedDate
			ELSE @ToDate END<= @ToDate)

		--User Portals
		SELECT
			 [UserId]
			,[PortalId]
			,[UserPortalId]
			,[CreatedDate]
			,[Authorised]
			,[IsDeleted]
			,[RefreshRoles]
			,[VanityUrl]
 		FROM dbo.[UserPortals]
		WHERE UserId IN(SELECT UserID FROM #tmpPagedUsers) AND PortalId = @PortalId

		--AspNet User
		SELECT * INTO #tmpAspNetUsers
 		FROM dbo.[aspnet_Users]
		WHERE  UserName IN(SELECT Username FROM #tmpPagedUsers)
			AND (CASE
			WHEN @FromDateUtc IS NULL THEN 0
			ELSE [LastActivityDate] END)>= ISNULL(@FromDateUtc,0)
			AND [LastActivityDate] <= @ToDateUtc

		SELECT * FROM #tmpAspNetUsers;
		--AspNet membership
		SELECT *
 		FROM dbo.[aspnet_Membership]
		WHERE UserId IN(SELECT UserId FROM #tmpAspNetUsers)

	DROP TABLE #tmpPagedUsers
	END
END
GO
