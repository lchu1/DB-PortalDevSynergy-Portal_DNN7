SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportTaxonomy_Terms]
    @PortalId INT,
	@ToDate   datetime,
	@FromDate	datetime=NULL
AS
BEGIN
	DECLARE @Now datetime = GETDATE()
	SELECT
		t.*, u1.Username AS CreatedByUserName, u2.Username AS LastModifiedByUserName
	FROM
		dbo.Taxonomy_Terms AS t
			INNER JOIN dbo.Taxonomy_Vocabularies v ON v.VocabularyID = t.VocabularyID
            INNER JOIN dbo.Taxonomy_ScopeTypes st ON st.ScopeTypeID = v.ScopeTypeID
			LEFT OUTER JOIN dbo.Users AS u1 ON t.CreatedByUserID = u1.UserID
			LEFT OUTER JOIN dbo.Users AS u2 ON t.LastModifiedByUserID = u2.UserID
	WHERE (st.ScopeType = 'Application' OR (st.ScopeType = 'Portal' AND v.ScopeID = @PortalId))
	  AND (COALESCE(t.LastModifiedOnDate, t.CreatedOnDate, @Now) <= @ToDate AND (@FromDate IS NULL OR ISNULL(t.LastModifiedOnDate, t.CreatedOnDate) >= @FromDate))
END
GO
