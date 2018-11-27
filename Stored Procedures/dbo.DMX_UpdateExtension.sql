SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UpdateExtension]
 @PortalId INT, 
 @AccessRights NVARCHAR (255), 
 @Addon NVARCHAR (50), 
 @ControlToLoad NVARCHAR (255), 
 @Custom NVARCHAR (400), 
 @DownloadUrl NVARCHAR (255), 
 @EditControl NVARCHAR (255), 
 @EntryTypes NVARCHAR (255), 
 @ExtensionKey NVARCHAR (50), 
 @Icon16 NVARCHAR (100), 
 @Icon32 NVARCHAR (100), 
 @IsPrivate BIT, 
 @MimeType VARCHAR (200), 
 @NodePattern NVARCHAR (50), 
 @ResourceFile NVARCHAR (255), 
 @SettingsControl NVARCHAR (250), 
 @ViewByDefault BIT, 
 @ViewControl NVARCHAR (255)
AS
UPDATE dbo.DMX_Extensions SET
 [AccessRights] = @AccessRights,
 [Addon] = @Addon,
 [ControlToLoad] = @ControlToLoad,
 [Custom] = @Custom,
 [DownloadUrl] = @DownloadUrl,
 [EditControl] = @EditControl,
 [EntryTypes] = @EntryTypes,
 [Icon16] = @Icon16,
 [Icon32] = @Icon32,
 [IsPrivate] = @IsPrivate,
 [MimeType] = @MimeType,
 [NodePattern] = @NodePattern,
 [ResourceFile] = @ResourceFile,
 [SettingsControl] = @SettingsControl,
 [ViewByDefault] = @ViewByDefault,
 [ViewControl] = @ViewControl
WHERE
 [ExtensionKey] = @ExtensionKey
 AND [PortalId] = @PortalId
GO
