SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[_Active_EOBOnly_Users_V]
AS
SELECT     TOP 100 PERCENT *
FROM         dbo._Active_EOB_Users_V
WHERE     (Company <> N'DEMO') AND (NOT (UserID IN
                          (SELECT     UserId
                            FROM          _Active_Claims_Users_V)))
ORDER BY Company, LastName, FirstName DESC

GO
