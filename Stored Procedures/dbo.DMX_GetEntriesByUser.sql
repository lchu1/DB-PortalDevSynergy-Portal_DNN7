SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_GetEntriesByUser]
 @Owner Int,
 @IncludeDeleted BIT
AS
SELECT
 e.*
FROM
 dbo.DMX_Entries e
WHERE
 e.Owner = @Owner
 AND ((NOT e.Deleted = 1) OR (@IncludeDeleted = 1))
GO
