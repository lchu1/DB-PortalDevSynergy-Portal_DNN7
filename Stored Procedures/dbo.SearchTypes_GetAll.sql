SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[SearchTypes_GetAll]
AS
    SELECT *
	FROM dbo.[SearchTypes]
GO
