SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ExportTaxonomy_VocabularyTypes]
AS
	SELECT
		*
	FROM
		dbo.Taxonomy_VocabularyTypes
GO
