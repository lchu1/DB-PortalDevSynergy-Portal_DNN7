SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PersonaBar_UpdateMenuController]
    @Identifier                 NVARCHAR(50),
    @Controller                 NVARCHAR(260),
    @CurrentUserId              INT
AS
BEGIN
    UPDATE dbo.[PersonaBarMenu]
        SET 
            Controller = @Controller,
            LastModifiedByUserId = CASE WHEN @CurrentUserId = -1 THEN NULL ELSE @CurrentUserId END,
            LastModifiedOnDate = GETDATE()
        WHERE Identifier = @Identifier
END
GO
