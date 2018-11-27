SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Personabar_GetUsersBySearchTerm]
	@PortalId      Int,           --  Null|-1: any Site
	@SortColumn    nVarChar(32),  --  Field Name, supported values see below. Null|'': sort by search priority
	@SortAscending Bit = 1,       --  Sort Direction
	@PageIndex     Int = 0,
	@PageSize      Int = 10,
	@SearchTerm    nVarChar(99),  --  Null|'': all items, append "%" to perform a left search
	@authorized    Bit,           --  Null: all, 0: unauthorized only, 1: authorized only
	@isDeleted     Bit,           --  Null: all, 0: undeleted    only, 1: deleted    only
	@Superusers    Bit            --  Null: all, 0: portal users only, 1: superusers only
AS
BEGIN
	IF @SearchTerm = N''   SET @SearchTerm = Null; -- Normalize parameter
	IF @SortColumn = N''   SET @SortColumn = N'Priority';
	IF @SortColumn Is Null SET @SortColumn = N'Priority';
	
	IF (@Superusers = 1)
	BEGIN
	  IF (@SearchTerm Is Null) -- search superusers
	  BEGIN
		SELECT U.UserID, U.Username, U.DisplayName, U.Email, U.CreatedOnDate, U.IsDeleted, Authorised, IsSuperUser, TotalCount
		FROM (SELECT UserID, Username, DisplayName, Email, CreatedOnDate, IsDeleted, 1 AS Authorised, IsSuperUser, Count(*) OVER () AS TotalCount,
				 ROW_NUMBER() OVER (ORDER BY CASE WHEN @SortColumn = N'Joined'      AND @SortAscending = 1 THEN UserID               END ASC, 
											 CASE WHEN @SortColumn = N'Joined'      AND @SortAscending = 0 THEN UserID               END DESC,
											 CASE WHEN @SortColumn = N'Email'       AND @SortAscending = 1 THEN Email                END ASC, 
											 CASE WHEN @SortColumn = N'Email'       AND @SortAscending = 0 THEN Email                END DESC,
											 CASE WHEN @SortColumn = N'DisplayName' AND @SortAscending = 1 THEN DisplayName          END ASC, 
											 CASE WHEN @SortColumn = N'DisplayName' AND @SortAscending = 0 THEN DisplayName          END DESC,
											 CASE WHEN @SortColumn = N'UserName'    AND @SortAscending = 1 THEN UserName			 END ASC,
											 CASE WHEN @SortColumn = N'UserName'    AND @SortAscending = 0 THEN UserName			 END DESC,
											 CASE WHEN @SortColumn = N'Priority'    AND @SortAscending = 1 THEN UserName			 END ASC, -- Priority not supported
											 CASE WHEN @SortColumn = N'Priority'    AND @SortAscending = 0 THEN UserName			 END DESC,-- Priority not supported
											 CASE WHEN @SortColumn = N'Modified'    AND @SortAscending = 1 THEN LastModifiedOnDate   END ASC, 
											 CASE WHEN @SortColumn = N'Modified'    AND @SortAscending = 0 THEN LastModifiedOnDate   END DESC) AS RowNumber 
		   FROM  dbo.[Users]
		   WHERE (IsSuperUser = 1)
		     AND (@isDeleted  Is Null OR IsDeleted = @isDeleted)) U
		WHERE RowNumber BETWEEN (@PageIndex * @PageSize + 1) AND ((@PageIndex + 1) * @PageSize)
		ORDER BY RowNumber
		OPTION (RECOMPILE);
	  END
	  ELSE -- search superusers using term
	  BEGIN
		SELECT UserID, Username, DisplayName, Email, CreatedOnDate, IsDeleted, 1 AS Authorised, IsSuperUser, TotalCount
		 FROM  (SELECT UserID, 
		               Username, 
					   DisplayName,
					   Email,
					   CreatedOnDate,
					   IsDeleted,
					   IsSuperUser,
		               Sum(1) N, 
					   Count(*) OVER ()   AS TotalCount,
		               ROW_NUMBER() OVER (ORDER BY CASE WHEN @SortColumn = N'Joined'      AND @SortAscending = 1 THEN UserID               END ASC, 
												   CASE WHEN @SortColumn = N'Joined'      AND @SortAscending = 0 THEN UserID               END DESC,
												   CASE WHEN @SortColumn = N'Email'       AND @SortAscending = 1 THEN Email                END ASC, 
												   CASE WHEN @SortColumn = N'Email'       AND @SortAscending = 0 THEN Email                END DESC,
												   CASE WHEN @SortColumn = N'DisplayName' AND @SortAscending = 1 THEN DisplayName          END ASC, 
												   CASE WHEN @SortColumn = N'DisplayName' AND @SortAscending = 0 THEN DisplayName          END DESC,
												   CASE WHEN @SortColumn = N'UserName'    AND @SortAscending = 1 THEN UserName			   END ASC,
												   CASE WHEN @SortColumn = N'UserName'    AND @SortAscending = 0 THEN UserName			   END DESC,
												   CASE WHEN @SortColumn = N'Priority'    AND @SortAscending = 1 THEN Sum(1)			   END ASC,
												   CASE WHEN @SortColumn = N'Priority'    AND @SortAscending = 0 THEN Sum(1)			   END DESC,
												   CASE WHEN @SortColumn = N'Modified'    AND @SortAscending = 1 THEN LastModifiedOnDate   END ASC, 
												   CASE WHEN @SortColumn = N'Modified'    AND @SortAscending = 0 THEN LastModifiedOnDate   END DESC) AS RowNumber 
				  FROM (SELECT UserID, Username, DisplayName, Email, CreatedOnDate, LastModifiedOnDate, IsDeleted, IsSuperUser
						FROM  dbo.[Users] 
						WHERE (UserName    Like @searchTerm)
						  AND (IsSuperUser = 1)
						  AND (@isDeleted  Is Null OR IsDeleted = @isDeleted) 
					   UNION SELECT UserID, Username, DisplayName, Email, CreatedOnDate, LastModifiedOnDate, IsDeleted, IsSuperUser
						FROM  dbo.[Users]
						WHERE (DisplayName Like @searchTerm)
						  AND (IsSuperUser = 1)
						  AND (@isDeleted  Is Null OR IsDeleted = @isDeleted) 
					   UNION SELECT UserID, Username, DisplayName, Email, CreatedOnDate, LastModifiedOnDate, IsDeleted, IsSuperUser
						FROM  dbo.[Users]
						WHERE (Email       Like @searchTerm)
						  AND (IsSuperUser = 1)
						  AND (@isDeleted  Is Null OR IsDeleted = @isDeleted) 
					   UNION SELECT UserID, Username, DisplayName, Email, CreatedOnDate, LastModifiedOnDate, IsDeleted, IsSuperUser
						FROM  dbo.[Users]
						WHERE (FirstName   Like @searchTerm)
						  AND FirstName Is Not Null AND FirstName != N'' 
						  AND (IsSuperUser = 1)
						  AND (@isDeleted  Is Null OR IsDeleted = @isDeleted) 
					   UNION SELECT UserID, Username, DisplayName, Email, CreatedOnDate, LastModifiedOnDate, IsDeleted, IsSuperUser
						FROM  dbo.[Users]
						WHERE (LastName    Like @searchTerm)
						  AND LastName  Is Not Null AND LastName  != N'' 
						  AND (IsSuperUser = 1)
						  AND (@isDeleted  Is Null OR IsDeleted = @isDeleted)) S 
					 GROUP BY UserID, Username, DisplayName, Email, CreatedOnDate, LastModifiedOnDate, IsDeleted, IsSuperUser) AS Sel
		WHERE Sel.RowNumber BETWEEN (@PageIndex * @PageSize + 1) AND ((@PageIndex + 1) * @PageSize)
		ORDER BY Sel.RowNumber
		OPTION (RECOMPILE);
	  END
	END
	ELSE IF (@SearchTerm Is Null)
	BEGIN -- display all portal users:
			DECLARE @TotalCount Int;
			SELECT @TotalCount = Count(1) 
			 FROM  dbo.[Users]       U
			 JOIN  dbo.[UserPortals] P ON U.UserID = P.UserID
			 WHERE P.PortalID = @PortalID
			   AND (@Superusers Is Null OR IsSuperUser = 0)
			   AND (@isDeleted  Is Null OR P.IsDeleted  = @isDeleted )
			   AND (@authorized Is Null OR P.Authorised = @authorized);
			   
			SELECT UserID, Username, DisplayName, Email, CreatedOnDate, IsDeleted, Authorised, IsSuperUser, @TotalCount AS TotalCount
			FROM
		     (SELECT U.UserID, U.Username, U.DisplayName, U.Email, U.CreatedOnDate, P.IsDeleted, P.Authorised, U.IsSuperUser,
			         ROW_NUMBER() OVER (ORDER BY CASE WHEN @SortColumn = N'Joined'      AND @SortAscending = 1 THEN U.UserID             END ASC, 
												 CASE WHEN @SortColumn = N'Joined'      AND @SortAscending = 0 THEN U.UserID             END DESC,
												 CASE WHEN @SortColumn = N'Email'       AND @SortAscending = 1 THEN Email                END ASC, 
												 CASE WHEN @SortColumn = N'Email'       AND @SortAscending = 0 THEN Email                END DESC,
												 CASE WHEN @SortColumn = N'DisplayName' AND @SortAscending = 1 THEN DisplayName          END ASC, 
												 CASE WHEN @SortColumn = N'DisplayName' AND @SortAscending = 0 THEN DisplayName          END DESC,
												 CASE WHEN @SortColumn = N'UserName'    AND @SortAscending = 1 THEN UserName			 END ASC,
												 CASE WHEN @SortColumn = N'UserName'    AND @SortAscending = 0 THEN UserName			 END DESC,
												 CASE WHEN @SortColumn = N'Priority'    AND @SortAscending = 1 THEN UserName			 END ASC, -- Priority not supported
												 CASE WHEN @SortColumn = N'Priority'    AND @SortAscending = 0 THEN UserName			 END DESC,-- Priority not supported
												 CASE WHEN @SortColumn = N'Modified'    AND @SortAscending = 1 THEN U.LastModifiedOnDate END ASC, 
												 CASE WHEN @SortColumn = N'Modified'    AND @SortAscending = 0 THEN U.LastModifiedOnDate END DESC) AS RowNumber 
			   FROM  dbo.[Users]       U
			   JOIN  dbo.[UserPortals] P ON U.UserID = P.UserID
			   WHERE P.PortalID = @PortalID
			     AND (@Superusers Is Null OR U.IsSuperuser = 0)
			     AND (@isDeleted  Is Null OR P.IsDeleted  = @isDeleted)
			     AND (@authorized Is Null OR P.Authorised = @authorized)) Sel
			 WHERE Sel.RowNumber BETWEEN (@PageIndex * @PageSize + 1) AND ((@PageIndex + 1) * @PageSize)
			 ORDER BY Sel.RowNumber
			 OPTION (RECOMPILE);
	END
	ELSE -- search portal users:
	BEGIN
		SELECT UserID, Username, DisplayName, Email, CreatedOnDate, IsDeleted, Authorised, IsSuperUser, TotalCount
		FROM  ( SELECT S.UserID, 
		               Username, 
					   DisplayName,
					   Email,
					   CreatedOnDate,
					   IsDeleted,
					   Authorised,
					   IsSuperUser,
		               Sum(1) N, 
					   Count(*) OVER ()   AS TotalCount,
		               ROW_NUMBER() OVER (ORDER BY CASE WHEN @SortColumn = N'Joined'      AND @SortAscending = 1 THEN S.UserID             END ASC, 
												   CASE WHEN @SortColumn = N'Joined'      AND @SortAscending = 0 THEN S.UserID             END DESC,
												   CASE WHEN @SortColumn = N'Email'       AND @SortAscending = 1 THEN Email                END ASC, 
												   CASE WHEN @SortColumn = N'Email'       AND @SortAscending = 0 THEN Email                END DESC,
												   CASE WHEN @SortColumn = N'DisplayName' AND @SortAscending = 1 THEN DisplayName          END ASC, 
												   CASE WHEN @SortColumn = N'DisplayName' AND @SortAscending = 0 THEN DisplayName          END DESC,
												   CASE WHEN @SortColumn = N'UserName'    AND @SortAscending = 1 THEN UserName			   END ASC,
												   CASE WHEN @SortColumn = N'UserName'    AND @SortAscending = 0 THEN UserName			   END DESC,
												   CASE WHEN @SortColumn = N'Priority'    AND @SortAscending = 1 THEN Sum(1)			   END ASC,
												   CASE WHEN @SortColumn = N'Priority'    AND @SortAscending = 0 THEN Sum(1)			   END DESC,
												   CASE WHEN @SortColumn = N'Modified'    AND @SortAscending = 1 THEN LastModifiedOnDate   END ASC, 
												   CASE WHEN @SortColumn = N'Modified'    AND @SortAscending = 0 THEN LastModifiedOnDate   END DESC) AS RowNumber 
				  FROM (SELECT UserID, Username, DisplayName, Email, CreatedOnDate, LastModifiedOnDate, IsSuperuser 
						FROM  dbo.[Users] 
						WHERE (UserName    Like @searchTerm)
						  AND (@isDeleted  Is Null OR IsDeleted = @isDeleted) 
					   UNION SELECT UserID, Username, DisplayName, Email, CreatedOnDate, LastModifiedOnDate, IsSuperuser 
						FROM  dbo.[Users]
						WHERE (DisplayName Like @searchTerm)
						  AND (@isDeleted  Is Null OR IsDeleted = @isDeleted) 
					   UNION SELECT UserID, Username, DisplayName, Email, CreatedOnDate, LastModifiedOnDate, IsSuperuser 
						FROM  dbo.[Users]
						WHERE (Email       Like @searchTerm)
						  AND (@isDeleted  Is Null OR IsDeleted = @isDeleted) 
					   UNION SELECT UserID, Username, DisplayName, Email, CreatedOnDate, LastModifiedOnDate, IsSuperuser 
						FROM  dbo.[Users]
						WHERE (FirstName   Like @searchTerm)
						  AND FirstName Is Not Null AND FirstName != N'' 
						  AND (@isDeleted  Is Null OR IsDeleted = @isDeleted) 
					   UNION SELECT UserID, Username, DisplayName, Email, CreatedOnDate, LastModifiedOnDate, IsSuperuser 
						FROM  dbo.[Users]
						WHERE (LastName    Like @searchTerm)
						  AND LastName  Is Not Null AND LastName  != N'' 
						  AND (@isDeleted  Is Null OR IsDeleted = @isDeleted)) S
                   JOIN	 dbo.[UserPortals] P ON S.UserID = P.UserID		
                   WHERE P.PortalID = @PortalID
					 AND (@Superusers Is Null OR S.IsSuperuser = 0)
					 AND (@isDeleted  Is Null OR P.IsDeleted  = @isDeleted)
			         AND (@authorized Is Null OR P.Authorised = @authorized)
				   GROUP BY S.UserID, Username, DisplayName, Email, CreatedOnDate, LastModifiedOnDate, IsDeleted, IsSuperuser, Authorised) AS Sel
		WHERE Sel.RowNumber BETWEEN (@PageIndex * @PageSize + 1) AND ((@PageIndex + 1) * @PageSize)
		ORDER BY Sel.RowNumber
		OPTION (RECOMPILE);
	END
END; --Procedure
GO
