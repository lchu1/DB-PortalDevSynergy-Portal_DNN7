SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[Export_ContentWorkflowStates]
	@WorkflowID     int
AS
BEGIN
	SELECT
		ws.*
	FROM
		dbo.ContentWorkflowStates ws
			INNER JOIN dbo.ContentWorkflows AS wf  ON wf.WorkflowID = ws.WorkflowID
	WHERE
		ws.WorkflowID = @WorkflowID
END
GO
