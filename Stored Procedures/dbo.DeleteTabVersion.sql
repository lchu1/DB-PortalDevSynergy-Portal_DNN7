SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DeleteTabVersion]
    @Id INT
AS
BEGIN
    DELETE FROM dbo.[TabVersions] WHERE TabVersionId = @Id
END
GO
