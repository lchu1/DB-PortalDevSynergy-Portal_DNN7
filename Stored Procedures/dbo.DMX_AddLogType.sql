SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DMX_AddLogType]
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
INSERT INTO dbo.DMX_LogTypes (
 [PortalId],
 [AttachFile],
 [CustomSend],
 [LogTypeKey],
 [NotifyApprovers],
 [NotifyAudit],
 [NotifyEditors],
 [NotifyOwner],
 [NotifySelf],
 [NotifySubscribers],
 [ResourceFile])
VALUES (
 @PortalId,
 @AttachFile,
 @CustomSend,
 @LogTypeKey,
 @NotifyApprovers,
 @NotifyAudit,
 @NotifyEditors,
 @NotifyOwner,
 @NotifySelf,
 @NotifySubscribers,
 @ResourceFile)
GO
