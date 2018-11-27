SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_UpdateLogType]
 @PortalId INT, 
 @AttachFile BIT, 
 @CustomSend BIT, 
 @LogTypeKey NVARCHAR (20), 
 @NotifyApprovers NVARCHAR (100), 
 @NotifyAudit BIT, 
 @NotifyEditors NVARCHAR (100), 
 @NotifyOwner NVARCHAR (100), 
 @NotifySelf NVARCHAR (100), 
 @NotifySubscribers NVARCHAR (100), 
 @ResourceFile NVARCHAR (150)
AS
UPDATE dbo.DMX_LogTypes SET
 [AttachFile] = @AttachFile,
 [CustomSend] = @CustomSend,
 [NotifyApprovers] = @NotifyApprovers,
 [NotifyAudit] = @NotifyAudit,
 [NotifyEditors] = @NotifyEditors,
 [NotifyOwner] = @NotifyOwner,
 [NotifySelf] = @NotifySelf,
 [NotifySubscribers] = @NotifySubscribers,
 [ResourceFile] = @ResourceFile
WHERE
 [LogTypeKey] = @LogTypeKey
 AND [PortalId] = @PortalId
GO
