SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddExtension]
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
INSERT INTO dbo.DMX_Extensions (
 [PortalId],
 [AccessRights],
 [Addon],
 [ControlToLoad],
 [Custom],
 [DownloadUrl],
 [EditControl],
 [EntryTypes],
 [ExtensionKey],
 [Icon16],
 [Icon32],
 [IsPrivate],
 [MimeType],
 [NodePattern],
 [ResourceFile],
 [SettingsControl],
 [ViewByDefault],
 [ViewControl])
VALUES (
 @PortalId,
 @AccessRights,
 @Addon,
 @ControlToLoad,
 @Custom,
 @DownloadUrl,
 @EditControl,
 @EntryTypes,
 @ExtensionKey,
 @Icon16,
 @Icon32,
 @IsPrivate,
 @MimeType,
 @NodePattern,
 @ResourceFile,
 @SettingsControl,
 @ViewByDefault,
 @ViewControl)
GO
