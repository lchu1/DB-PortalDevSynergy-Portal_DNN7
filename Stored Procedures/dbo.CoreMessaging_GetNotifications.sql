SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[CoreMessaging_GetNotifications]
	@UserID              Int,
	@PortalID            Int,
	@AfterNotificationID Int,
	@NumberOfRecords     Int
AS
BEGIN
	--Get the top message for each conversation
	SELECT TOP(@NumberOfRecords)
			M.[MessageID],
			M.[NotificationTypeId],
			M.[To],
			M.[From],
			M.[Subject],
			M.[Body],
			M.[SenderUserID],
			M.[ExpirationDate],
            M.[IncludeDismissAction],
			M.[CreatedByUserID],
			M.[CreatedOnDate],
			M.[LastModifiedByUserID],
			M.[LastModifiedOnDate],
            M.[Context],
			ROW_NUMBER() OVER(ORDER BY M.MessageId DESC) AS RowNumber
		FROM dbo.[CoreMessaging_Messages]       AS M
		JOIN dbo.[CoreMessaging_MessageRecipients] MR 
				ON (M.[MessageID] = MR.[MessageID])
		WHERE ([NotificationTypeId] IS NOT NULL)
		  AND (MR.[UserID]  = @UserID)
		  AND (M.[PortalID] = @PortalID)
		  AND (ISNull(M.[ExpirationDate], GETUTCDATE()) >= GETUTCDATE())
		  AND (((@AfterNotificationID IS NULL OR @AfterNotificationID = -1) AND M.[MessageID] > -1) OR (@AfterNotificationID > -1 AND M.[MessageID] < @AfterNotificationID))
		ORDER BY RowNumber ASC
END
GO
