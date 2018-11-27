SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Journal_ListForSummary]
	@PortalId int,
	@ModuleId int,
	@CurrentUserId int,
	@RowIndex int,
	@MaxRows int,
	@IncludeAllItems int = 0,
	@IsDeleted int = 0	
	AS
	IF @RowIndex = 0
	BEGIN
		SET @RowIndex = 1
	END
	DECLARE @EndRow int
	SET @EndRow = @RowIndex + @MaxRows - 1;
	DECLARE @j TABLE(id int IDENTITY, journalid int, datecreated datetime)
	IF EXISTS(SELECT * from dbo.[Journal_TypeFilters] WHERE ModuleId = @ModuleId)
	INSERT INTO @j 
		SELECT j.journalid, jt.datecreated from (
			SELECT DISTINCT js.JournalId from dbo.[Journal] as j
				INNER JOIN dbo.[Journal_Security] as js ON js.JournalId = j.JournalId
				INNER JOIN dbo.[Journal_User_Permissions](@PortalId,@CurrentUserId ,1) as t ON t.seckey = js.SecurityKey
				WHERE j.PortalId = @PortalId
			) as j INNER JOIN dbo.[Journal] jt ON jt.JournalId = j.JournalId AND jt.PortalId = @PortalId
			INNER JOIN dbo.[Journal_TypeFilters] as jf ON jf.JournalTypeId = jt.JournalTypeId AND jf.ModuleId = @ModuleId
			ORDER BY jt.DateCreated DESC, jt.JournalId DESC;
	ELSE
	INSERT INTO @j 
		SELECT j.journalid, jt.datecreated from (
			SELECT DISTINCT js.JournalId from dbo.[Journal] as j
				INNER JOIN dbo.[Journal_Security] as js ON js.JournalId = j.JournalId
				INNER JOIN dbo.[Journal_User_Permissions](@PortalId,@CurrentUserId ,1) as t ON t.seckey = js.SecurityKey
				WHERE j.PortalId = @PortalId
			) as j INNER JOIN dbo.[Journal] jt ON jt.JournalId = j.JournalId AND jt.PortalId = @PortalId
			ORDER BY jt.DateCreated DESC, jt.JournalId DESC;
	WITH journalItems  AS
	(
		SELECT	j.JournalId,
				ROW_NUMBER() OVER (ORDER BY j.JournalId DESC) AS RowNumber
		FROM	dbo.[Journal] as j INNER JOIN @j as jtmp ON jtmp.JournalId = j.JournalId
		WHERE j.PortalId = @PortalId
	)
	SELECT	j.JournalId, j.JournalTypeId, j.Title, j.Summary, j.UserId, j.DateCreated, j.DateUpdated, j.PortalId,
				j.ProfileId, j.GroupId, j.ObjectKey, j.AccessKey,
				"JournalOwner" = '<entity><id>' + CAST(p.UserId as nvarchar(150)) + '</id><name><![CDATA[' + p.DisplayName + ']]></name></entity>',
				"JournalAuthor" = CASE WHEN ISNULL(a.UserId,-1) >0 THEN '<entity><id>' + CAST(a.UserId as nvarchar(150)) + '</id><name><![CDATA[' + a.DisplayName + ']]></name></entity>' ELSE '' END,
				"JournalOwnerId" = ISNULL(j.ProfileId,j.UserId),
				 jt.Icon, jt.JournalType,
				"Profile" = CASE WHEN j.ProfileId > 0 THEN '<entity><id>' + CAST(p.UserID as nvarchar(150)) + '</id><name><![CDATA[' + p.DisplayName + ']]></name><vanity></vanity></entity>' ELSE '' END,
				"SimilarCount" = (SELECT COUNT(JournalId) FROM dbo.Journal WHERE ContentItemId = j.ContentItemId AND JournalTypeId = j.JournalTypeId),
				jd.JournalXML, j.ContentItemId, j.ItemData, RowNumber, j.IsDeleted, j.CommentsDisabled, j.CommentsHidden
	FROM	journalItems as ji INNER JOIN 
		dbo.[Journal] as j ON j.JournalId = ji.JournalId INNER JOIN
	dbo.[Journal_Types] as jt ON jt.JournalTypeId = j.JournalTypeId LEFT OUTER JOIN
				dbo.[Journal_Data] as jd on jd.JournalId = j.JournalId LEFT OUTER JOIN
				dbo.[Users] AS p ON j.ProfileId = p.UserID LEFT OUTER JOIN
				dbo.[Users] AS a ON j.UserId = a.UserID
	WHERE	((@IncludeAllItems = 0) AND (RowNumber BETWEEN @RowIndex AND @EndRow AND j.IsDeleted = @IsDeleted)) 
			OR 
			((@IncludeAllItems = 1) AND (RowNumber BETWEEN @RowIndex AND @EndRow ))
	ORDER BY RowNumber ASC;
GO
