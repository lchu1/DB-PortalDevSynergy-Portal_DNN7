SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GetPackageDependencies]
AS
	SELECT * FROM dbo.[PackageDependencies]
GO
