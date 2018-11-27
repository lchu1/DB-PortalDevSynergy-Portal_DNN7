SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportTaxonomy_Vocabularies]
    @PortalId INT,
	@ToDate   datetime,
	@FromDate	datetime=NULL
AS
BEGIN
	DECLARE @Now datetime = GETDATE()
	SELECT DISTINCT
		v.*, u1.Username AS CreatedByUserName, u2.Username AS LastModifiedByUserName
	FROM
		dbo.Taxonomy_Vocabularies AS v
            INNER JOIN dbo.Taxonomy_ScopeTypes st ON st.ScopeTypeID = v.ScopeTypeID
			INNER JOIN dbo.Taxonomy_Terms t ON v.VocabularyID = t.VocabularyID
			LEFT OUTER JOIN dbo.Users AS u1 ON v.CreatedByUserID = u1.UserID
			LEFT OUTER JOIN dbo.Users AS u2 ON v.LastModifiedByUserID = u2.UserID
	WHERE (st.ScopeType = 'Application' OR (st.ScopeType = 'Portal' AND v.ScopeID = @PortalId))
	AND (
			(COALESCE(v.LastModifiedOnDate, v.CreatedOnDate, @Now) <= @ToDate AND (@FromDate IS NULL OR ISNULL(v.LastModifiedOnDate, v.CreatedOnDate) >= @FromDate))
		 OR
			(COALESCE(t.LastModifiedOnDate, t.CreatedOnDate, @Now) <= @ToDate AND (@FromDate IS NULL OR ISNULL(t.LastModifiedOnDate, t.CreatedOnDate) >= @FromDate))
		)
END
GO
