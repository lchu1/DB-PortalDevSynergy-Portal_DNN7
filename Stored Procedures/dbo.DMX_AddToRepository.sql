SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddToRepository]
 @PortalId Int
AS
INSERT INTO dbo.DMX_Repository (
 [Blob],
 [PortalId]
) VALUES (
 0x0,
 @PortalId
)
select SCOPE_IDENTITY()
GO
