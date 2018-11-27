SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportTaxonomy_ScopeTypes]
AS
	SELECT
		*
	FROM
		dbo.Taxonomy_ScopeTypes
GO
