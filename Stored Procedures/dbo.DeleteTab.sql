SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DeleteTab]
  @TabId INT  -- ID of tab to delete; Not Null and > 0
AS
BEGIN
    DECLARE @TabOrder INT
    DECLARE @ParentId INT
    DECLARE @ContentItemId INT
	DECLARE @PortalId INT
    SELECT @TabOrder = TabOrder, @ParentId = ParentID, @ContentItemID = ContentItemID, @PortalId = PortalID FROM dbo.[Tabs] WHERE TabID = @TabId

    -- Delete Tab --
    DELETE FROM dbo.[Tabs] WHERE TabID = @TabId

    -- Update TabOrder of remaining Tabs --
    UPDATE dbo.[Tabs]
        SET TabOrder = TabOrder - 2
        WHERE ISNULL(ParentID, -1) = ISNULL(@ParentId , -1) AND TabOrder > @TabOrder 
		AND (PortalID = @PortalId OR (PortalID IS NULL AND @PortalId IS NULL))

    -- Delete Content Item --
    DELETE FROM dbo.[ContentItems] WHERE ContentItemID = @ContentItemId
END
GO
